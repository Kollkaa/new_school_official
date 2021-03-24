import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';

class CourseController extends GetxController {
  HomeController _homeController=Get.find();

  var id =Get.arguments;
  @override
  void onInit() async {
    super.onInit();
    var response =await _homeController.getCourse(id);

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
