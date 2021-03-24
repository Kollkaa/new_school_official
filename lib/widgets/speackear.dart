import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

class SpeakerDialog extends StatelessWidget{
  HomeController _homeController =Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: Get.width,
          height: 549,
          child:new Container(
            height:549,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  ),                  width: Get.width,
                  height: 549,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 7),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Center(
                          child: Container(
                            width: 64,
                            height: 3,
                            color: Color(0xffC4C4C4),
                          ),
                        ),onTap: (){
                          Get.back();
                      },
                      ),
                      SizedBox(height: 57,),
                      Expanded(child: ListView
                        (
                        children: [

                          Container(
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 135,
                                  width: 135,
                                  decoration:BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage("${_homeController.course['kurses'][0]['spicker_image']}"),fit: BoxFit.cover)
                                  ),
                                ),
                                SizedBox(height: 21,),
                                Text("${_homeController.course['kurses'][0]['spicker_name']}",maxLines:1,textAlign: TextAlign.center
                                    ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
                              ],
                            ),
                          ),
                          SizedBox(height: 21,),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),

                            child: Text("${_homeController.course['kurses'][0]['spicker_desc']}"
                                ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,letterSpacing: 0.5,height:1.5,color: Colors.black,fontFamily: "Raleway")),
                          ),
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}