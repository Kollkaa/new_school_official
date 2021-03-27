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
import 'package:dio/dio.dart' as dios;
import 'package:new_school_official/service/backend.dart';

class MainController extends GetxController {

  var currentIndex= 0.obs;
  var image= File("1").obs;
  final GetStorage box = GetStorage();
  RxBool auth=true.obs;
  RxList widgets=[].obs;

  var profile={}.obs;

  var phoneEditingController=new TextEditingController();

  var passEditingController=new TextEditingController();

  var getUservideo_cab=[].obs;

  var getUservideo_time=[].obs;

  var getUservideo_time_all=[].obs;

  var getStats={}.obs;


  var lastnameEditingController=new TextEditingController();

  var nameEditingController=new TextEditingController();

  var passEditEditingController=new TextEditingController();

  var passOldEditingController=new TextEditingController();

  var passConfEditingController=new TextEditingController();

  var emailConfEditEditingController=new TextEditingController();

  var emailEditEditingController=new TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    auth.value=await box.read("auth");
    if(box.read("id")!=null) {
      initProfile(box.read("id"));
    }
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

  initProfile(id)async {
    dios.Response responces =await Backend().getUser(id:id);
    profile.value=responces.data['clients'][0];
    nameEditingController = new TextEditingController(text: profile['name']);
    lastnameEditingController = new TextEditingController(text: profile['lastname']);
    dios.Response getUservideo_cab =await Backend().getUservideo_cab(id:id);
    dios.Response getUservideo_time =await Backend().getUservideo_time(id:id);
    dios.Response getUservideo_time_all =await Backend().getUservideo_time_all(id:id);
    print(getUservideo_time.data['lessons']);
    dios.Response getStats =await Backend().getStat(id:id);
    this.getStats.value=getStats.data['user_stats'][0];

    this.getUservideo_cab.value=getUservideo_cab.data['lessons_cabinet'];
    this.getUservideo_time.value=getUservideo_time.data['lessons']!=null?getUservideo_time.data['lessons']:[];
    this.getUservideo_time_all.value=getUservideo_time_all.data['lessons'];
    print(this.getUservideo_time.length);
  }
  @override
  void onReady() {
    super.onReady();
    this.getUservideo_time=this.getUservideo_time;
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
