import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/profile/views/edit_profile.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leadingWidth: 120,
            leading: GestureDetector(
              child: Row(
                children: [
                  SizedBox(width: 11,),
                  Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                  SizedBox(width: 3,),
                  Text(
                    "Назад",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                  ),
                ],
              ),
              onTap: (){
                Get.back();
              },
            ),
            title: Text(
              "Настройки",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Raleway'),
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 15,),
                     GestureDetector(
                       child:  Container(
                         decoration: BoxDecoration(
                             border: Border(bottom: BorderSide(width: 1,color: Color(0xffECECEC)))
                         ),
                         height: 45,
                         margin:EdgeInsets.only(
                             left: 17,right: 17
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                                 "Редактирование профиля",
                               style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A),fontFamily: 'Raleway'),

                             ),
                             SvgPicture.asset("assets/icons/Vector (7).svg")
                           ],
                         ),
                       ),
                       onTap: (){
                         Get.dialog(EditProfile());
                       },
                     ),
                      GestureDetector(
                        child:  Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1,color: Color(0xffECECEC)))
                          ),
                          height: 45,
                          margin:EdgeInsets.only(
                              left: 17,right: 17
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Смена пароля",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A),fontFamily: 'Raleway'),

                              ),
                              SvgPicture.asset("assets/icons/Vector (7).svg")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child:  Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1,color: Color(0xffECECEC)))
                          ),
                          height: 45,
                          margin:EdgeInsets.only(
                              left: 17,right: 17
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Смена email",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A),fontFamily: 'Raleway'),

                              ),
                              SvgPicture.asset("assets/icons/Vector (7).svg")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child:  Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1,color: Color(0xffECECEC)))
                          ),
                          height: 45,
                          margin:EdgeInsets.only(
                              left: 17,right: 17
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Поддержка",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A),fontFamily: 'Raleway'),

                              ),
                             SvgPicture.asset("assets/icons/Vector (7).svg")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child:  Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1,color: Color(0xffECECEC)))
                          ),
                          height: 45,
                          margin:EdgeInsets.only(
                              left: 17,right: 17
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Версия приложений",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A),fontFamily: 'Raleway'),

                              ),
                              Text(
                                "5.3.0",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7c7c7c7),fontFamily: 'Raleway'),

                              ),
                            ],
                          ),
                        ),
                      )

                    ],
                  )
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(50, 50, 71, 0.06),
                          offset: Offset(0,2),
                          spreadRadius: 4,
                          blurRadius: 2
                      )
                    ],
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      "Выйти из аккаунта",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),

                    ),
                  )
                ),
              )
            ],
          ),
        )
    );
  }

}