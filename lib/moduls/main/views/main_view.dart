import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/custom/bottom_navigation.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/home/views/home.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/search/views/search_view.dart';
import 'package:new_school_official/storage/colors/main_color.dart';


class MainScreen extends StatelessWidget{

  final MainController _mainController = Get.put(MainController());

  BottomNavigationitem _bottomNavigationitem =BottomNavigationitem();



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light,  statusBarIconBrightness: Brightness.light,    statusBarColor: Colors.white,
        ));
    return Obx(
            ()=>
        _mainController.widgets.length!=0?Scaffold(
            bottomNavigationBar: CupertinoTabBar(
              border: Border(
                  top: BorderSide(
                      width: 1,color: Color(0xffECECEC)

                  )
              ),
              onTap: _mainController.onIndexChanged,
              currentIndex: _mainController.currentIndex.value,
              backgroundColor: white_color,
              items: [
                _bottomNavigationitem.showItem(_mainController.currentIndex.value==0, "home.svg", 23),
                _bottomNavigationitem.showItem(_mainController.currentIndex.value==1, "search.svg", 23),
                _bottomNavigationitem.showItem(_mainController.currentIndex.value==2, "statistik.svg", 23),
                _bottomNavigationitem.showItem(_mainController.currentIndex.value==3, "download.svg", 23),
                _bottomNavigationitem.showItem(_mainController.currentIndex.value==4, "profile.svg", 23),
              ],
            ),
            body: _mainController.widgets[_mainController.currentIndex.value]
        ):Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black,
          child: Center(
              child: SvgPicture.asset("assets/icons/Group 2.svg")
          ),
        )
    );
  }
}