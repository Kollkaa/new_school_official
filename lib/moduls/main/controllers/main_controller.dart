import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/home/views/home.dart';
import 'package:new_school_official/moduls/main/views/download_page.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/moduls/search/views/search_view.dart';
import 'package:new_school_official/moduls/static/views/static_view.dart';

class MainController extends GetxController {

  var currentIndex= 0.obs;
  var image= File("1").obs;
  final GetStorage box = GetStorage();
  RxBool auth=true.obs;
  RxList widgets=[].obs;

  List profile;

  var phoneEditingController=new TextEditingController();

  var passEditingController=new TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    auth.value=await box.read("auth");

    print(auth.value);
    auth.value=auth.value!=null?auth.value:false;

    widgets.value=[
      HomePage(),
      SearchScreen(),
      StaticScreen(),
      DownloadPage(),
      auth.value?ProfilePage():AuthPage(),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    auth.close();
    super.onClose();
  }
  void onIndexChanged(input) {
      currentIndex.value = input;

  }
}
