import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

  }
}
