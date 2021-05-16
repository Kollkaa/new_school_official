import 'package:dio/dio.dart' as dios;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

import 'dialog_payment.dart';

class Reg extends StatefulWidget {
  PageController pageController;

  Reg(this.pageController);

  @override
  State<StatefulWidget> createState() {
    return StateReg();
  }
}

class StateReg extends State<Reg> {
  HomeController _homeController = Get.put(HomeController());
  AuthController _authController = Get.put(AuthController());
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 27, bottom: 40),
            child: GestureDetector(
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff000000),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Назад",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Raleway'),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
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
                    Text(
                      "или",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff999999),
                          fontWeight: FontWeight.w400,
                          height: 1,
                          fontFamily: "Raleway"),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 21),
                        child: FlatButton(
                          padding: EdgeInsets.all(1),
                          minWidth: Get.width - 50,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: Container(
                              height: 50,
                              width: Get.width - 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(50, 50, 71, 0.06),
                                        offset: Offset(0, 2),
                                        spreadRadius: 4,
                                        blurRadius: 2)
                                  ],
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: Color(0xff000000))),
                              child: Center(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      "assets/icons/newApple.svg",
                                    ),
                                    width: 20.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.white
                                                    .withOpacity(0.3)))),
                                    width: Get.width - 122,
                                    child: Center(
                                      child: Text(
                                        "Вход с Apple ID",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                            fontFamily: "Raleway"),
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                          onPressed: () {},
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 21),
                        child: FlatButton(
                          padding: EdgeInsets.all(1),
                          minWidth: Get.width - 50,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: Container(
                              height: 50,
                              width: Get.width - 50,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(50, 50, 71, 0.06),
                                        offset: Offset(0, 2),
                                        spreadRadius: 4,
                                        blurRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: Color(0xffEBEBEB))),
                              child: Center(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                        "assets/icons/newGoogle.svg"),
                                    width: 20.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Color(0xFFEBEBEB)))),
                                    width: Get.width - 124,
                                    child: Center(
                                      child: Text(
                                        "Вход с Google",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            height: 1,
                                            fontFamily: "Raleway"),
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                          onPressed: () {},
                        )),
                    FlatButton(
                      child: Container(
                          height: 50,
                          width: Get.width - 50,
                          child: Center(
                            child: Text(
                              "Уже есть аккаунт?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff484848),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Raleway"),
                            ),
                          )),
                      onPressed: () {
                        widget.pageController.jumpToPage(1);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  Widget makeTitleh2() {
    return Text(
      "Создать аккаунт",
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Raleway"),
    );
  }

  Widget makeDescription() {
    return Text("Для получения полного доступа",
        style: TextStyle(
            fontSize: 14,
            color: Color(0xff3A3A3A),
            fontWeight: FontWeight.w300,
            fontFamily: "Raleway"));
  }

  Widget makeTextFieldLog() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25, right: 25, top: 26),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Color(0xffEBEBEB))),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000).withOpacity(0.8)),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "E-mail",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        onChanged: _authController.onChange,
        controller: _authController.phoneRegEditingController,
      ),
    );
  }

  Widget makeTextFieldPass() {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(left: 25, right: 25, top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Color(0xffEBEBEB))),
        child: Row(
          children: [
            Container(
              width: Get.width - 120,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withOpacity(0.8)),
                maxLines: 1,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hasFloatingPlaceholder: true,
                  hintText: "Пароль",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffc4c4c4)),
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
                onSaved: (String value) {},
                onChanged: _authController.onChange,
                controller: _authController.passRegEditingController,
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
        ));
  }

  Widget makeButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 22, top: 20, left: 25, right: 25),
      child: FlatButton(
        padding: EdgeInsets.all(1),
        minWidth: Get.width - 50,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Container(
            height: 50,
            width: Get.width - 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color(0xff000000))),
            child: Center(
              child: Text(
                "Продолжить",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1,
                    fontFamily: "Raleway"),
              ),
            )),
        onPressed: () async {
          if (_authController.phoneRegEditingController.text != null) {
            dios.Response responce = await Backend().register(
                email: _authController.phoneRegEditingController.text,
                pas: _authController.passRegEditingController.text);
            if (responce.statusCode == 200) {
              print(responce.data);
              await box.write("auth", true);
              _mainController.profile = {}.obs;
              _mainController.email.value =
                  _authController.phoneRegEditingController.text;
              _mainController.password.value =
                  _authController.passRegEditingController.text;
              Get.dialog(Payment());
            }
          }
        },
      ),
    );
  }
}
