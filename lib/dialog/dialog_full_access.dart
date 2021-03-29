import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/home/views/home.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:dio/dio.dart' as dios;

import 'atuhor.dart';

class GetFullAccess extends StatelessWidget{
  HomeController _homeController =Get.put(HomeController());
  AuthController _authController = Get.put(AuthController());
  MainController _mainController=Get.find();
  final GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: white_color,
        body: SafeArea(
            child: Column(
                children: [
                  Expanded(
                      child: ListView(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 27),
                                child:GestureDetector(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 15,),
                                      Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                                      SizedBox(width: 3,),
                                      Text(
                                        "Назад",
                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                                      ),
                                    ],
                                  ),
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40,left: 15,right: 15),
                              width: Get.width-30,
                              height: 223,
                              child: Stack(
                                children: [
                                  Container(
                                      width: Get.width-30,
                                      height: 223,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              "assets/images/Group 248.png",
                                            )
                                        ),
                                      )
                                  ),
                                  // Positioned(top:11,right: 13,
                                  //     child: GestureDetector(
                                  //       child: SvgPicture.asset("assets/icons/close-3 1 (1).svg",height: 11,width: 11,),
                                  //       onTap: (){
                                  //         _homeController.banner.value=false;
                                  //       },
                                  //     )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.only(left: 36,right: 36,top: 7),
                                        width: Get.width,
                                        child:  AutoSizeText(
                                            'ПОЛНЫЙ ДОСТУП'.toUpperCase(),maxLines:1,minFontSize: 11,textAlign:TextAlign.left,
                                            style: TextStyle(fontSize: 18,letterSpacing: 0.5,fontWeight: FontWeight.w900,color: Colors.white,fontFamily: "Bold")
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 36,right: 36,top: 5),
                                        width: Get.width,
                                        child:    Opacity(
                                          child: Text(
                                              'Получите полный доступ на все курсы и последующиеза 299 руб в месяц'
                                              ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white,letterSpacing: 0.5,fontFamily: "Raleway")
                                          ),
                                          opacity: 0.7,
                                        ),
                                      ),

                                      Opacity(
                                        child: GestureDetector(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 39,right: 39,top: 15),
                                            padding: EdgeInsets.all(9),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1,color: Colors.white),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Text(
                                                  'Начать учиться',style: TextStyle(fontSize: 14,letterSpacing: 0.5,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: "Raleway")
                                              ),
                                            ),
                                          ),
                                          onTap: ()async{
                                            Get.dialog(Author());

                                          },
                                        ),
                                        opacity: 0.8,
                                      ),
                                      // SizedBox(height: 7,),
                                      // Opacity(
                                      //   child:  Text(
                                      //       '30 дней бесплатно, далее 199 ₽ в месяц',style: TextStyle(fontSize: 9,fontWeight: FontWeight.w300,color: Colors.white,fontFamily: "Raleway",letterSpacing: 0.5)
                                      //   ),
                                      //   opacity: 0.7,
                                      // ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  "Вы уже являетесь нашим подписчиком?",
                                  style:TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff555555)
                                  )
                                ),
                              ),
                            )
                          ]
                      )
                  )
                ]
            )
        )
    );


  }

}