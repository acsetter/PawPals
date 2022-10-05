import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  /// A static reference to this controller instance
  static UserController to = Get.find();

  Rxn<User> firebaseUser = Rxn<User>();



  /// Called 1 frame after onInit().
  /// It is the perfect place to enter navigation events,
  /// like snackbar, dialogs, or a new route, or async request.
  @override
  void onReady() async {
    super.onReady();
  }

  /// Called before onDelete method.
  /// onClose might be used to dispose resources used by the controller.
  /// Like closing events, or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  @override
  void onClose() async {
    super.onClose();
  }
}