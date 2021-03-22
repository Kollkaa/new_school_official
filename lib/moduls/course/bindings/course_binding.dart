import 'package:get/get.dart';
import 'package:new_school_official/moduls/course/controllers/course_controller.dart';

class CourseBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CourseController>(
      () => CourseController(),
    );
  }

}
