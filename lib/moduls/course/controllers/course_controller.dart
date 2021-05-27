import 'package:get/get.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class CourseController extends GetxController {
  MainController _mainController = Get.find();
  var id = Get.arguments;
  var statTest;
  var length;
  @override
  void onInit() async {
    getStatByTest();
    super.onInit();
  }

  getStatByTest() async {
    var bak = Backend();
    print(id);
    print(_mainController.profile['id']);
    var responce =
        await bak.getTestStat(course_id: id, id: _mainController.profile['id']);
    var response = await bak.getTestByidCourse(course_id: id);
    print(response);
    try {
      length = response.data['questions'].length;
    } catch (e) {
      length = 0;
    }
    print(responce.data);
    statTest = responce.data['test_result'][0];
    if (statTest["answers_to_pass"] == '0') {
      statTest["answers_to_pass"] = '4';
      statTest["passed"] = false;
      statTest["message"] = "Тест не пройден";
    }
    print(statTest);
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
