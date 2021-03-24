import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'dart:ui' as ui;

import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:dio/dio.dart' as dios;

class AuthController extends GetxController {
  final GetStorage box = GetStorage();
  MainController mainController=Get.find();

  var codeEditingController= new TextEditingController(text: "+380");

  var phoneEditingController= new TextEditingController();

  var focusNode=new FocusNode();

  var passEditingController= new TextEditingController();

  var passRegEditingController= new TextEditingController();

  var phoneRegEditingController= new TextEditingController();

  String get code => codeEditingController.text;

  String get phone => phoneEditingController.text;

  Rx<Duration> recordedTime =  Duration.zero.obs;

  var _countdownTime = 0.obs;


  @override
  void onInit() {
    focusNode.requestFocus();
    super.onInit();

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
  void getCode()async{
    if(phoneEditingController.text!=null){
      dios.Response responce =await Backend().auth(email: phoneEditingController.text,pas: passEditingController.text);
      if(responce.statusCode==200){
        print(responce.data);
        box.write("auth", true);
       mainController.auth.value=true;
        mainController.widgets.removeAt(4);
        mainController.widgets.add(ProfilePage());
        mainController.profile=[];
      }
    }
  }
  void getRegister()async{
    if(phoneRegEditingController.text!=null){
      dios.Response responce =await Backend().register(email: phoneRegEditingController.text,pas: passRegEditingController.text);
      if(responce.statusCode==200){
        print(responce.data);
        box.write("auth", true);
        mainController.auth.value=true;
        mainController.widgets.removeAt(4);
        mainController.widgets.add(ProfilePage());
        mainController.profile=[];
      }
    }
  }
  void onChange(sting) {
    if(phoneEditingController.text.length>=12){
      focusNode.unfocus();
      phoneEditingController.text.substring(0, 12);
    }
  }




  //Componets for auth

  Widget makeTitle(){
    return Positioned(
      top:10,
      left: 0,
      right: 0,
      child:Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("NEW",style: auth_title_text_style,),
            Text(" ",style: auth_title2_text_style,),
            Text("SCHOOL",style:auth_title_text_style),
          ],
        ),
      ),
    );
  }




}
