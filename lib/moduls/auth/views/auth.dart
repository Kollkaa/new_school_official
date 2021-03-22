
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class AuthPage extends StatelessWidget {
  AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: white_color,
      body:  Center(
        child: Container(
          padding: EdgeInsets.all(48),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeTitleh2(),
                SizedBox(height: 3,),
                makeDescription(),
                SizedBox(height:29 ,),
                Column(
                  children: [
                    makeTextFieldLog(),
                    SizedBox(height: 17,),
                    makeTextFieldPass(),
                    SizedBox(height: 16,),
                    makeButton(),
                    SizedBox(height: 23),
                    Text("или",style: TextStyle(fontSize: 16,color: text_color_title,fontWeight: FontWeight.w300,height: 1),),
                    SizedBox(height: 21),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  width: 1,
                                  color: Color(0xff000000)
                              )
                          ),
                          width: Get.width-28,
                          child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/apple.svg"),
                                  SizedBox(width: 10,),

                                  Text(
                                    "Вход с Apple ID",
                                    style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400,height: 1),
                                  ),
                                ],
                              )
                          )
                      ),
                      onTap: _authController.getCode,
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color(0xff000000)
                              )
                          ),
                          width: Get.width-28,
                          child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset("assets/images/ddjvludx0aa77mu 1.jpg"),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Вход с Google",
                                    style: TextStyle(fontSize: 15,color: text_color_title,fontWeight: FontWeight.w400,height: 1),
                                  ),
                                ],
                              )
                          )
                      ),
                      onTap: _authController.getCode,
                    ),
                    SizedBox(height: 15),
                    Container(
                        width: Get.width-28,
                        child:  Center(
                          child: Text(
                            "Войдя в систему, вы соглашаетесь с нашей политикой конфиденциальности", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15,color: Color(0xff6A6A6a),fontWeight: FontWeight.w300,height: 1),
                          ),
                        )
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }


  Widget makeTitleh2(){
    return Text("Войти",style: auth_titleh1_text_style,);
  }

  Widget makeDescription(){
    return Text("или создать профиль",style:auth_description_text_style);
  }

  Widget makeTextFieldLog(){
    return Container(
      width: Get.width-28,
        padding: EdgeInsets.only(left: 14),

        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Color(0xffc4c4c4)
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
      width: Get.width-28,
      padding: EdgeInsets.only(left: 14),

      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Color(0xffc4c4c4)
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
        padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Color(0xff000000)
              )
          ),
        width: Get.width-28,
        child: Center(
          child: Text(
            "Продолжить",
            style: TextStyle(fontSize: 15,color: text_color_title,fontWeight: FontWeight.w400,height: 1),
          ),
        )
      ),
      onTap: _authController.getCode,
    );
  }
}