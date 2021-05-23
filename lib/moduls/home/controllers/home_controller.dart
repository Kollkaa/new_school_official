import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/search/views/course_by_group.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';

class HomeController extends GetxController {
  MainController _mainController = Get.find();

  var codeEditingController = new TextEditingController(text: "+380");

  var phoneEditingController = new TextEditingController();

  var focusNode = new FocusNode();

  var category = "Музыка".obs;

  Rx<Duration> recordedTime = Duration.zero.obs;

  var _countdownTime = 0.obs;

  var popular = [].obs;
  var news = [].obs;
  var videos = {};
  var categorise = [].obs;

  var course = {};

  var coursesByCat = [].obs;

  var videoPos = new Duration().obs;

  var statCourse = {};

  @override
  void onInit() {
    focusNode.requestFocus();
    super.onInit();
    getCourses();
    getCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneEditingController.dispose();
    super.onClose();
  }

  void getCode() {
    if (phoneEditingController.text.length == 9) {
      Get.toNamed(Routes.CODE_CONFIRM);
    }
  }

  void onChange(sting) {
    if (phoneEditingController.text.length >= 9) {
      focusNode.unfocus();
      phoneEditingController.text.substring(0, 9);
    }
  }

  //Componets for auth

  void getCourses() async {
    var response = await Backend().getMainCourse();
    print(response.headers);
    if (response.statusCode == 200) {
      popular.value = response.data['popular'];
      news.value = response.data['new'];
    }
  }

  void getCategories() async {
    var response = await Backend().getMainCategories();
    print(response.headers);
    if (response.statusCode == 200) {
      print(response.data);
      categorise.value = response.data['categories'];
      await getCoursesByCatStart(categorise[0]['id'], categorise[0]['name']);
    }
  }

  void getCoursesByCatStart(id, text) async {
    var response = await Backend().getCourseByCat(id);
    print(response.headers);
    if (response.statusCode == 200) {
      print(response.data['kurses'].length);
      coursesByCat.value = response.data['kurses'];
      category.value = text;
    }
  }

  void getCoursesByCat(id, text) async {
    var response = await Backend().getCourseByCat(id);
    print(response.headers);
    if (response.statusCode == 200) {
      print(response.data['kurses'].length);
      coursesByCat.value = response.data['kurses'];
      category.value = text;
      Get.to(CourseByGroup(), duration: Duration());
    }
  }
}
