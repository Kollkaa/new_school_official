import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';

class EditProfile extends StatelessWidget{
  MainController _mainController = Get.find();

 // final picker = ImagePicker();


  Future getImage() async {
   // final pickedFile = await picker.getImage(source: ImageSource.camera);

     // if (pickedFile != null) {
    //    _mainController.image.value = File(pickedFile.path);
    //  } else {
//      }
  }
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

          ),
          body: Container(
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(50, 50, 71, 0.08),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(
                                  0,0
                              )
                          )
                        ],
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:_mainController.image.value.path!="1"
                                ? Image.file(_mainController.image.value)
                                :  AssetImage("assets/images/Image.png",)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/icons/camera-2 1.svg")
                      ],
                    ),
                  ),
                  onTap: (){
                    getImage();
                  },
                ),
                makeTextFieldLog(),
                makeTextFieldPass(),
                makeButton()
              ],
            ),
          ),
        )
    );
  }

  Widget makeTextFieldLog(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25,right: 25,top: 36),
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

        controller: _mainController.phoneEditingController,

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

        controller: _mainController.passEditingController,

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
              "Сохранить",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),
            ),
          )
      ),
    );
  }

}