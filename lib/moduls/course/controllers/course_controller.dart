import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class CourseController extends GetxController {
  MainController _mainController = Get.find();
  var id =Get.arguments;
  var statTest;
  var length;
  @override
  void onInit() async {
    print(id);
    getStatByTest();
    super.onInit();
  }
  getStatByTest()async{
    var bak = Backend();
    var responce=await bak.getTestStat(course_id: id,id: _mainController.profile['id']);
    var response=await bak.getTestByidCourse(course_id: id);
    length=response.data['questions'].length;
    print(responce.data);
    statTest=responce.data['test_result'][0];
    Get.appUpdate();
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
