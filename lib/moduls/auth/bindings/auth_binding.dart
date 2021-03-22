import 'package:get/get.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );

  }
}
