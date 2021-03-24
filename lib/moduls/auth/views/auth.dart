
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class AuthPage extends StatelessWidget {
  AuthController _authController = Get.put(AuthController());
  MainController _mainController=Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: white_color,
      body:  Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeTitleh2(),
                makeDescription(),
                makeTextFieldLog(),
                makeTextFieldPass(),
                makeButton(),
                Text("или",style: TextStyle(fontSize: 14,color: Color(0xff999999),fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),),
                GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(left: 25,right: 25,top: 21),
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(50, 50, 71, 0.06),
                                offset: Offset(0,2),
                                spreadRadius: 4,
                                blurRadius: 2
                            )
                          ],
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1,
                              color: Color(0xff000000)
                          )
                      ),
                      width: Get.width-28,
                      child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/icons/apple.svg"),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border(left: BorderSide(width: 1,color: Colors.white.withOpacity(0.3)))
                                ),
                                width: Get.width-122,
                                child:  Center(
                                  child:  Text(
                                    "Вход с Apple ID",
                                    style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),
                                  ),
                                ),
                              ),
                              Opacity(opacity: 0,
                                child:   SvgPicture.asset("assets/icons/apple.svg"),
                              )

                            ],
                          )
                      )
                  ),
                  onTap: _authController.getCode,
                ),
                GestureDetector(
                  child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 25,right: 25,top: 15),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(50, 50, 71, 0.06),
                                offset: Offset(0,2),
                                spreadRadius: 4,
                                blurRadius: 2
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1,
                              color: Color(0xff000000)
                          )
                      ),
                      width: Get.width-28,
                      child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/ddjvludx0aa77mu 1.jpg"),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border(left: BorderSide(width: 1,color: Colors.white.withOpacity(0.3)))
                                ),
                                width: Get.width-124,
                                child:  Center(
                                  child: Text(
                                    "Вход с Google",
                                    style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),
                                  ),
                                ),
                              ),
                              Opacity(opacity: 0,
                                child:                                   Image.asset("assets/images/ddjvludx0aa77mu 1.jpg"),
                              )
                            ],
                          )
                      )
                  ),
                  onTap: _authController.getCode,
                ),
                SizedBox(height: 15),
               GestureDetector(
                 child: Container(
                     width: Get.width-28,
                     child:  Center(
                       child: Text(
                         "Создать учетную запись?", textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 14,color:Color(0xff484848),fontWeight: FontWeight.w400,fontFamily: "Raleway" ),
                       ),
                     )
                 ),
                 onTap: (){
                   if(!_mainController.auth.value) {
                     print("213");
                     _mainController.widgets.removeAt(4);
                     _mainController.widgets.add(RegisterPage());
                     _mainController.currentIndex.value=4;
                   }                 },
               )

              ],
            ),
          ),
        ),
      )
    );
  }


  Widget makeTitleh2(){
    return Text("Войти",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,fontFamily: "Raleway" ),);
  }

  Widget makeDescription(){
    return Text("Введите свои данные для входа",style:TextStyle(fontSize: 14,color:Color(0xff3A3A3A), fontWeight: FontWeight.w300,fontFamily: "Raleway" ));
  }

  Widget makeTextFieldLog(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25,right: 25,top: 26),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Color(0xffEBEBEB)
          )
      ),
      child:TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xffc4c4c4)
        ),

        maxLines: 1,
        decoration: InputDecoration(
          hintText: "E-mail",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)
          ),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),

        onChanged: _authController.onChange,
        controller: _authController.phoneEditingController,

      ),

    );
  }
  Widget makeTextFieldPass(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),

      margin: EdgeInsets.only(left: 25,right: 25,top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Color(0xffEBEBEB)
          )
      ),
      child:TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xffc4c4c4)
        ),

        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Пароль",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)
          ),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),

        onChanged: _authController.onChange,
        controller: _authController.passEditingController,

      ),

    );
  }

  Widget makeButton(){
    return GestureDetector(
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 25,right: 25,bottom: 22,top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1,
                  color: Color(0xff000000)
              )
          ),
        child: Center(
          child: Text(
            "Продолжить",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),
          ),
        )
      ),
      onTap: _authController.getCode,
    );
  }
}