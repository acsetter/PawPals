import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_geo_hash/geohash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:paw_pals/constants/app_colors.dart';

/// Location service class for geohashing and other location-based actions.
/// <br /><br />
/// **Helpful Links**
/// * <a href="https://pub.dev/packages/location">Location Package (installed)</a>
/// * <a href="https://pub.dev/packages/flutter_geo_hash">Geohash Package (installed)</a>
/// * <a href="https://gis.stackexchange.com/questions/115280/what-is-the-precision-of-geohash">What is the precision of Geohash?</a>
class LocationService {
  // I think maybe should pass in user model or post model to diferentiate which 
  // is being modified or added to.
  static getLocation() async {
    Location location = new Location();

    MyGeoHash myGeoHash = MyGeoHash();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    String? hash = myGeoHash.geoHashForLocation(
        GeoPoint(_locationData.latitude!, _locationData.longitude!));
    print('${_locationData.latitude}, ${_locationData.longitude}, ${hash}');
// returns a model but what about location for post and user themselves. That
// is whats being compared.
    return OurLocation(
        latitude: _locationData.latitude,
        longitude: _locationData.longitude,
        geoHash: hash);
  }
}

/// Use something like this to return
/// from LocationService.getLocation()
class OurLocation {
  double? longitude;
  double? latitude;
  String? geoHash;
  OurLocation(
      {required this.longitude, required this.latitude, required this.geoHash});
}
