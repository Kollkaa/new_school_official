import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class SubscribeProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateSubscribeProfile();
  }
}

class StateSubscribeProfile extends State<SubscribeProfile> {
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

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
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "Подписка оформлена!",
                    style: TextStyle(
                        fontSize: 25,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget makeTextFieldEmail() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25, right: 25, top: 35),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Color(0xffEBEBEB))),
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000).withOpacity(0.8)),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Новый email",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        controller: _mainController.emailEditEditingController,
      ),
    );
  }

  Widget makeButton() {
    return Container(
        margin: EdgeInsets.only(bottom: 22, top: 20, left: 25, right: 25),
        child: FlatButton(
          padding: EdgeInsets.all(1),
          minWidth: Get.width - 50,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Container(
              width: Get.width - 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Color(0xff000000))),
              child: Center(
                child: Text(
                  "Сохранить",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      fontFamily: "Raleway"),
                ),
              )),
          onPressed: () async {
            if (_mainController.emailConfEditEditingController.text ==
                    _mainController.emailEditEditingController.text &&
                _mainController.emailEditEditingController.text != "" &&
                _mainController.emailEditEditingController.text.contains("@")) {
              var response = await Backend().editEmail(
                box.read("id"),
                _mainController.emailEditEditingController.text,
              );

              print(response.data);

              if (response.statusCode == 200) {
                Get.snackbar("", "",
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.white,
                    colorText: Colors.blue,
                    snackPosition: SnackPosition.BOTTOM,
                    messageText: Text(
                      "email изменен",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    ));
                var responces = await Backend().getUser(id: box.read("id"));
                _mainController.profile.value = responces.data['clients'][0];
              }
            }
          },
        ));
  }

  Widget makeTextFieldEmailConf() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25, right: 25, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Color(0xffEBEBEB))),
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000).withOpacity(0.8)),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Подтверждение",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        controller: _mainController.emailConfEditEditingController,
      ),
    );
  }
}
