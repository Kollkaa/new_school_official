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
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAuth();
  }
}

class StateAuth extends State<AuthPage> {
  AuthController _authController = Get.put(AuthController());
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: Center(
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    minWidth: Get.width - 28,
                    child: Container(
                        width: Get.width - 28,
                        child: Center(
                          child: Text(
                            "Создать учетную запись?",
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
                        print("213");
                        _mainController.widgets.removeAt(4);
                        _mainController.widgets.add(RegisterPage(
                          false,
                        ));
                        _mainController.currentIndex.value = 4;
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget makeTitleh2() {
    return Text(
      "Войти",
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Raleway"),
    );
  }

  Widget makeDescription() {
    return Text("Введите свои данные для входа",
        style: TextStyle(
            fontSize: 14,
            color: Color(0xff3A3A3A),
            fontWeight: FontWeight.w300,
            fontFamily: "Raleway"));
  }

  Widget makeTextFieldLog() {
    return Container(
      height: 50,
      width: Get.width - 50,
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
        controller: _authController.phoneEditingController,
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
                controller: _authController.passEditingController,
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
            if (_authController.phoneEditingController.text != null) {
              dios.Response responce = await Backend().auth(
                  email: _authController.phoneEditingController.text,
                  pas: _authController.passEditingController.text);
              print(responce);
              print('++++++++++');
              if (responce.statusCode == 200 && !responce.data[0]['error']) {
                await box.write("auth", true);
                _mainController.profile = {}.obs;
                await box.write("id", responce.data[0]['id']);
                await _mainController.initProfile(responce.data[0]['id']);
                _mainController.auth.value = true;
                _mainController.widgets.removeAt(4);
                _mainController.widgets.add(ProfilePage());
                if (int.tryParse(_mainController.profile['subscriber']) != 1) {
                  Get.dialog(Payment(
                    subscriber: _mainController.profile['subscriber'],
                  ));
                }
                setState(() {});
              } else {
                Get.snackbar("", "",
                    backgroundColor: Colors.white,
                    colorText: Colors.blue,
                    snackPosition: SnackPosition.BOTTOM,
                    messageText: Text(
                      "Неверный Email или Пароль",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ));
              }
            }
          },
        ));
  }
}
