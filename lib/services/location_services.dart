import 'package:flutter_geo_hash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:paw_pals/models/post_model.dart';
import 'package:paw_pals/models/pref_model.dart';

/// Location service class for geohashing and other location-based actions.
/// <br /><br />
/// **Helpful Links**
/// * <a href="https://pub.dev/packages/location">Location Package (installed)</a>
/// * <a href="https://pub.dev/packages/flutter_geo_hash">Geohash Package (installed)</a>
/// * <a href="https://gis.stackexchange.com/questions/115280/what-is-the-precision-of-geohash">What is the precision of Geohash?</a>
class LocationService {
  /// Gets the users location. This also handles asking for permission to use
  /// location and the things like that. Returns the longitude, latitude and
  /// a geoHash of the users location as a OurLocation Object.
  /// When location is turned off returns OurLocation object with the
  /// latitude and longitude of uncw to use. HQ for Paw Pals
  static Future<OurLocation> getLocation() async {
    Location location = Location();

    MyGeoHash myGeoHash = MyGeoHash();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        String? hash =
            myGeoHash.geoHashForLocation(const GeoPoint(34.2261, -77.8718));
        Get.snackbar('Location Services: OFF\nTap To Go To Settings', 'Using Paw Pals HQ Location: UNCW',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            onTap: (snack) => Geolocator.openLocationSettings());
        return OurLocation(
            latitude: 34.2261, longitude: -77.8718, geoHash: hash);
      }
    }
// 34.2261, -77.8718
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        String? hash =
            myGeoHash.geoHashForLocation(const GeoPoint(34.2261, -77.8718));
        Get.snackbar('Location Services: OFF\nTap To Go To Settings', 'Using Paw Pals HQ Location: UNCW',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            onTap: (snack) => Geolocator.openLocationSettings());
        return OurLocation(
            latitude: 34.2261, longitude: -77.8718, geoHash: hash);
      }
    }

    locationData = await location.getLocation();

    String? hash = myGeoHash.geoHashForLocation(
        GeoPoint(locationData.latitude!, locationData.longitude!));
    // Get.snackbar('Location Services: ON\nTap To Go To Settings', 'Using Users Location',
    //         snackPosition: SnackPosition.BOTTOM,
    //         duration: const Duration(seconds: 5),
    //         onTap: (snack) => Geolocator.openLocationSettings());

    return OurLocation(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        geoHash: hash);
  }

  /// used to get the new list of post models for the screen
  /// based on the search radius
  /// returns a list of post models
  static Future<List<PostModel>?> updatePostListWithSearchRadius(
      {required List<PostModel> oldPostModelList,
      required PreferencesModel? userPreferenceModel}) async {
    PostModel postModel;
    double postModelDistance;
    List<PostModel> newPostModelList = [];
    OurLocation userLocation = await getLocation();
    int? searchRadius = userPreferenceModel?.searchRadius;
    searchRadius ??= 150;

    for (postModel in oldPostModelList) {

      // If post has no lat and long use users current lat and long
      postModel.latitude ??= userLocation.latitude;
      postModel.longitude ??= userLocation.longitude;

      postModelDistance = await getDistance(
          latA: userLocation.latitude!,
          longA: userLocation.longitude!,
          latB: postModel.latitude!,
          longB: postModel.longitude!);
      if (postModelDistance <= searchRadius) {
        newPostModelList.add(postModel);
      }
    }

    return newPostModelList;
  }

  /// function to get the distance between two pairs of coordinates
  /// returns distance in miles
  static getDistance({
    required double latA,
    required double longA,
    required double latB,
    required double longB
  }) {
    // 1m = 1/1609.344mi
    return Geolocator.distanceBetween(latA, longA, latB, longB) * (1/1609.344);
  }

  static Future<double> getLiveDistance({
    required double latB,
    required double longB
  }) async {
    return await getLocation().then((curr) =>
        getDistance(latA: curr.latitude!, longA: curr.longitude!,
            latB: latB, longB: longB));
  }
}

/// Use something like this to return
/// from LocationService.getLocation()
class OurLocation {
  double? longitude;
  double? latitude;
  String? geoHash;
  OurLocation({
    required this.longitude,
    required this.latitude,
    required this.geoHash
  });
}
