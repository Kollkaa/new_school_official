import 'package:get/get.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

  }
}
