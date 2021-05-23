import 'package:dio/dio.dart' as dios;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/dialog/dialog_payment.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

import 'auth.dart';

class RegisterPage extends StatefulWidget {
  final bool backButton;

  RegisterPage(this.backButton);
  @override
  State<StatefulWidget> createState() {
    return StateRegister();
  }
}

class StateRegister extends State<RegisterPage> {
  AuthController _authController = Get.put(AuthController());
  MainController _mainController = Get.find();

  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: ListView(
          children: [
            widget.backButton
                ? makeBackButton()
                : SizedBox(
                    height: 45.0,
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
                                          color:
                                              Color.fromRGBO(50, 50, 71, 0.06),
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
                                          color:
                                              Color.fromRGBO(50, 50, 71, 0.06),
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
                      widget.backButton
                          ? Container()
                          : FlatButton(
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
                                if (!_mainController.auth.value) {
                                  _mainController.widgets.removeAt(4);
                                  _mainController.widgets.add(AuthPage());
                                  _mainController.currentIndex.value = 4;
                                }
                              },
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
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

  Widget makeBackButton() {
    return Container(
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
    );
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

  bool _passwordVisible = false;

  Widget makeTextFieldPass() {
    return Container(
        height: 50,
        width: Get.width - 50,
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
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: _passwordVisible ? null : Color(0xFFC4C4C4),
              ),
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
              if (_authController.passRegEditingController.text.length < 6) {
                Get.snackbar("", "",
                    backgroundColor: Colors.white,
                    colorText: Colors.blue,
                    snackPosition: SnackPosition.BOTTOM,
                    messageText: Text(
                      "Пароль должен быть менее 6 символов",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ));
              } else {
                dios.Response responce = await Backend().register(
                    email: _authController.phoneRegEditingController.text,
                    pas: _authController.passRegEditingController.text);
                print(responce);
                print('++++++++++++++++++');
                if (responce.statusCode == 200 &&
                    responce.data[0]['id'] != null) {
                  print(responce.data);
                  await box.write("auth", true);
                  _mainController.profile = {}.obs;
                  await box.write("id", responce.data[0]['id']);
                  await _mainController.initProfile(responce.data[0]['id']);
                  _mainController.auth.value = true;
                  _mainController.widgets.removeAt(4);
                  _mainController.widgets.add(ProfilePage());
                  if (int.tryParse(_mainController.profile['subscriber']) !=
                      1) {
                    Get.dialog(Payment(
                      subscriber: _mainController.profile['subscriber'],
                    ));
                  } else {
                    _mainController.currentIndex.value = 4;
                  }
                  setState(() {});
                } else if (responce.data[0]['error']) {
                  Get.snackbar("", "",
                      backgroundColor: Colors.white,
                      colorText: Colors.blue,
                      snackPosition: SnackPosition.BOTTOM,
                      messageText: Text(
                        responce.data[0]['message'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ));
                } else {
                  await box.write("auth", true);
                  _mainController.profile = {}.obs;
                  await box.write("id", '204');
                  dios.Response getStats = await Backend().getStat(id: '204');
                  await _mainController.initProfile('204');
                  _mainController.auth.value = true;
                  _mainController.widgets.removeAt(4);
                  _mainController.widgets.add(ProfilePage());
                  if (int.tryParse(_mainController.profile[0]['subscriber']) !=
                      1) {
                    Get.dialog(Payment(
                      subscriber: '0',
                    ));
                  } else {
                    _mainController.currentIndex.value = 4;
                  }
                  setState(() {});
                }
              }
            }
          },
        ));
  }
}
