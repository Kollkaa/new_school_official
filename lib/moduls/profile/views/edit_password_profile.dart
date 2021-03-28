import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class EditPasswordProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StatePasEdit();
  }

}
class StatePasEdit extends State<EditPasswordProfile> {
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  bool _passwordOldVisible=false;

  bool _passwordConfVisible=false;

  bool _passwordVisible=false;


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
          body: Container(
            child: Column(
              children: [
                Expanded(child: ListView(
                  children: [
                    SizedBox(height: 50,),
                    Column(
                      children: [
                        Text("Изменить пароль",style: TextStyle(
                            fontSize: 25,height: 1.5,fontWeight: FontWeight.w700,fontFamily: 'Raleway'),
                        ),
                        Text("Заполните форму для измененияя пароля",style: TextStyle(
                            fontSize: 14,color:Color(0xff3a3a3a),height: 1.5,fontWeight: FontWeight.w300,fontFamily: 'Raleway'),),
                      ],
                    ),
                    makeTextFieldOld(),
                    makeTextFieldPass(),
                    makeTextFieldPassConf(),
                    makeButton()
                  ],
                ))
              ],
            ),
          ),
        )
    );
  }


  Widget makeTextFieldPass() {
   return Container(
        height: 50,
        width: Get.width-50,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(left: 25,right: 25,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1,
                color: Color(0xffEBEBEB)
            )
        ),
        child:Row(
          children: [
            Container(
              width: Get.width-120,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withOpacity(0.8)
                ),

                maxLines: 1,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hasFloatingPlaceholder: true,
                  hintText: "Новый пароль",
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

                validator: (String value) {
                  if (value.isEmpty) {
                    return "*Password needed";
                  }
                },
                onSaved: (String value) {

                },
                controller: _mainController.passEditEditingController,

              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ],
        )

    );

  }

  Widget makeButton() {
    return Container(
        margin: EdgeInsets.only(bottom: 22,top: 20,left: 25,right: 25),
        child: FlatButton(
          padding: EdgeInsets.all(1),

          minWidth: Get.width-50,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Container(
              width: Get.width-50,
              height: 50,
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
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1,
                  fontFamily: "Raleway"),
            ),
          )
      ),
      onPressed: () async {
        if(_mainController.passConfEditingController.text==_mainController.passEditEditingController.text&&
            _mainController.passConfEditingController.text!=""&&_mainController.passConfEditingController.text!=null
        ){
          var response = await Backend().editPassword(
            box.read("id"), _mainController.passConfEditingController.text,);
          print(response.data);
         if(response.statusCode==200){
           Get.snackbar("",  "",duration:Duration(seconds: 1),backgroundColor: Colors.white,colorText: Colors.blue,snackPosition: SnackPosition.BOTTOM,messageText: Text("пароль изменен",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),));

           var responces = await Backend().getUser(id: box.read("id"));
           _mainController.profile.value = responces.data['clients'][0];
         }
        }
      },
    ));
  }

  Widget makeTextFieldOld() {
    return Container(
        height: 50,
        width: Get.width-50,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(left: 25,right: 25,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1,
                color: Color(0xffEBEBEB)
            )
        ),
        child:Row(
          children: [
            Container(
              width: Get.width-120,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withOpacity(0.8)
                ),

                maxLines: 1,
                obscureText: !_passwordOldVisible,
                decoration: InputDecoration(
                  hasFloatingPlaceholder: true,
                  hintText: "Старый пароль",
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

                validator: (String value) {
                  if (value.isEmpty) {
                    return "*Password needed";
                  }
                },
                onSaved: (String value) {

                },
                controller: _mainController.passOldEditingController,

              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _passwordOldVisible = !_passwordOldVisible;
                });
              },
              child: Icon(
                  _passwordOldVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ],
        )

    );
  }

  Widget makeTextFieldPassConf() {
    return Container(
        height: 50,
        width: Get.width-50,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(left: 25,right: 25,top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1,
                color: Color(0xffEBEBEB)
            )
        ),
        child:Row(
          children: [
            Container(
              width: Get.width-120,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withOpacity(0.8)
                ),

                maxLines: 1,
                obscureText: !_passwordConfVisible,
                decoration: InputDecoration(
                  hasFloatingPlaceholder: true,
                  hintText: "Подтверждение",
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

                validator: (String value) {
                  if (value.isEmpty) {
                    return "*Password needed";
                  }
                },
                onSaved: (String value) {

                },
                controller: _mainController.passConfEditingController,

              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _passwordConfVisible = !_passwordConfVisible;
                });
              },
              child: Icon(
                  _passwordConfVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ],
        )

    );

  }
}