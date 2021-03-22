import 'package:get/get.dart';
import 'package:new_school_official/moduls/search/controllers/search_controller.dart';
import 'package:new_school_official/moduls/static/controllers/static_controller.dart';

class StaticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticController>(
      () => StaticController(),
    );

  }
}
