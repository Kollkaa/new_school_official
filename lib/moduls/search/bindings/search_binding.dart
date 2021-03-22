import 'package:get/get.dart';
import 'package:new_school_official/moduls/search/controllers/search_controller.dart';

class CourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );

  }
}
