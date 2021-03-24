import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

class DownloadPage extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_color,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
              top:0
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(
                      left: 22,right: 22,top: 27,
                    ),
                    child: Text("Мои загрузки",style: TextStyle(fontSize: 25,color: Color(0xff000000),fontWeight: FontWeight.w700,height: 1,fontFamily: "Raleway"),)
                ),
                Container(
                  width: Get.width,
                  height: Get.height-178,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 134,
                        height: 134,
                        padding: EdgeInsets.all(33),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF9F9F9)
                        ),
                        child: Image.asset("assets/images/download 1.png"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Пока загрузок нет",textAlign: TextAlign.center,style: TextStyle(fontSize: 17,height: 1.5,fontWeight: FontWeight.w600,fontFamily: "Raleway"),
                      ),
                      Text(
                        "Загружайте курсы, чтобы Вы всегда могли обучаться, даже если вы в офлайн.",textAlign: TextAlign.center,style: TextStyle(fontSize:14,height:1.5,fontWeight: FontWeight.w300,fontFamily: "Raleway"),
                      )
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }

}