import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/course/views/course_view.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/controllers/profile_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class ProfilePage extends StatelessWidget {
  ProfileController _profileController =Get.put(ProfileController());
  HomeController _homeController =Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white_color,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         margin: EdgeInsets.only(left: 20,top: 40),
                         child: Text(
                           "Профиль",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Raleway'),
                         ),
                       ),
                       GestureDetector(
                         child: Icon(Icons.exit_to_app),
                         onTap: (){
                           _profileController.getCode();
                         },
                       )
                     ],
                   )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 66),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/60 x 60.jpg")
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Aidar Akmaev",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Raleway'),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Настройки",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey,fontFamily: 'Raleway'),
                        ),
                      )
                    ],
                  ),
                ),
                getStatistik(),
                getType("Мой список",_homeController.news.length,
                    getitemOtherCard,_homeController.news
                ),
                getType("Продолжить просмотр",4,
                    getitemOtherCard,_homeController.popular
                ),
                getType("Рекомендуемые тесты",_homeController.news.length,
                    getitemOtherCard,_homeController.news
                ),
                getType("Завершенные курсы",4,
                    getitemOtherCard,_homeController.popular
                ),
                SizedBox(height: 40,)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getStatistik(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              width: 1,color: Color(0xffECECEC)
          )
      ),
      height: 68,
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 38,top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "9"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Курса в процессе"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "248"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              Text(
                  "Часов обучено"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "1"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              Text(
                  "Курсов пройдено"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }

  Widget getType(text,length,item,type){
    return Container(
      padding: EdgeInsets.only(bottom: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15),
            child:
            Text("${text}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

          ),

          Container(
            margin: EdgeInsets.only(top: 7),
            width: Get.width,
            height: 142,
            child:  ListView.builder(
                padding: EdgeInsets.only(left: 15),

                scrollDirection: Axis.horizontal,
                itemCount: length,
                itemBuilder: (c,i){
                 return item("${type[i]['name']}","${type[i]['banner_small']}",type[i]['id']);
                }
            ),
          )
        ],
      ),
    );
  }

  Widget getitemOtherCard(text,image,id){
    return  GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 142,
        width: 216,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue,
            image: DecorationImage(image: NetworkImage("${image}"),fit: BoxFit.cover)
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(

                height: 50,
                width: 216,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(1), Colors.black.withOpacity(0)]
                    )
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 18,right: 10,bottom: 12),
                child: AutoSizeText(
                  text,
                  style: white_title2_card_text_title,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: ()async{
        var response =await _homeController.getCourse(id);
        Get.toNamed(Routes.COURSE);
      },
    );
  }



}
