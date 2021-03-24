import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'dart:ui' as ui;

import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class HomeController extends GetxController {

  MainController _mainController =Get.find();
  RxBool banner=true.obs;

  var codeEditingController= new TextEditingController(text: "+380");

  var phoneEditingController= new TextEditingController();

  var focusNode=new FocusNode();


  var category="Музыка".obs;


  Rx<Duration> recordedTime =  Duration.zero.obs;

  var _countdownTime = 0.obs;

  var popular =[].obs;
  var news=[].obs;
  var videos={}.obs;
  var categorise=[].obs;

  var course={}.obs;

  var coursesByCat=[].obs;

  var videoPos=new Duration().obs;


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
  void getCode(){
    if(phoneEditingController.text.length==9){
      Get.toNamed(Routes.CODE_CONFIRM);
    }
  }
  void onChange(sting) {
    if(phoneEditingController.text.length>=9){
      focusNode.unfocus();
      phoneEditingController.text.substring(0, 9);
    }
  }


  //Componets for auth


  void getCourses()async {
    var  response=await Backend().getMainCourse();
    print(response.headers);
    if(response.statusCode==200)
      {
        print(response.data);
        popular.value=response.data['new'];
        news.value=response.data['new'];
      }
  }

  void getCategories()async {
    var  response=await Backend().getMainCategories();
    print(response.headers);
    if(response.statusCode==200)
    {
      print(response.data);
      categorise.value=response.data['categories'];
      await getCoursesByCatStart(categorise[0]['id'],categorise[0]['name']);

    }
  }

  void getCourse(id)async {
    var  response=await Backend().getCourse(id);
    print(response.headers);
    if(response.statusCode==200)
    {
      print(response.data);
      course.value=response.data;
      response=await Backend().getVideos(id);
      videos.value=response.data;
    }
  }

  void getCoursesByCatStart(id,text)async{
    var  response=await Backend().getCourseByCat(id);
    print(response.headers);
    if(response.statusCode==200)
    {
      print(response.data['kurses'].length);
      coursesByCat.value=response.data['kurses'];
      category.value=text;

    }
  }
  void getCoursesByCat(id,text)async{
    var  response=await Backend().getCourseByCat(id);
    print(response.headers);
    if(response.statusCode==200)
    {
      print(response.data['kurses'].length);
      coursesByCat.value=response.data['kurses'];
     category.value=text;
     _mainController.currentIndex.value=1;
    }
  }
}
