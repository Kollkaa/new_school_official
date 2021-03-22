
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';

class ProfileController extends GetxController {
  MainController _mainController=Get.find();
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
  void getCode()async{
        box.write("auth", false);
        _mainController.auth.value=false;
        _mainController.widgets.removeAt(4);
        _mainController.widgets.add(AuthPage());
   }
}
