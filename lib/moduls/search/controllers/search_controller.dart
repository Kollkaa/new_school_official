import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';

class SearchController extends GetxController {
  HomeController _homeController =Get.put(HomeController());

  String  get title => _homeController.category.value;
   get courses => _homeController.coursesByCat;

  @override
  void onInit() async {
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

}
