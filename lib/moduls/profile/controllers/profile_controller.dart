import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';

class ProfileController extends GetxController {
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getInfoUser() {}
  void getCode() async {
    await box.write("auth", false);
    await box.write("id", null);
    await (_mainController.auth.value = false);
    await (_mainController.banner.value = true);
    await (_mainController.listContCourse.value = []);
    await (_mainController.allCourse = []);
    await (_mainController.profile = {}.obs);
    await (_mainController.finishedCourses.value = []);
    await (_mainController.searchCourse.value = []);
    await _mainController.widgets.removeAt(4);
    await _mainController.widgets.add(AuthPage());
    Get.appUpdate();
  }
}
