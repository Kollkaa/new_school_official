import 'package:get/get.dart';
import 'package:new_school_official/moduls/test/controller/test_controller.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(
      () => TestController(),
    );

  }
}
