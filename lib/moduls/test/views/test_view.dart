
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/test/controller/test_controller.dart';
import 'package:new_school_official/moduls/test/views/finish_page.dart';
import 'package:new_school_official/moduls/test/views/question_page.dart';
import 'package:new_school_official/moduls/test/views/start_page.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateTestScreen();
  }

}
class StateTestScreen extends State<TestScreen>{
  TestController testController=Get.put(TestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 12,right: 14,top: 27,
                          ),
                          child: Icon(Icons.clear,size: 25,),
                        ),
                        onTapDown: (_){
                          Get.dialog(
                            Center(
                              child:Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: 248,
                                    height: 106,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              child: Icon(Icons.clear),
                                              onTapDown: (_){
                                                Get.back();
                                              },
                                            ),
                                            SizedBox(width: 4,),

                                          ],
                                        ),
                                        SizedBox(height: 6,),

                                        Container(
                                          child: Text("Точно хотите выйти?",
                                            style:TextStyle(fontSize: 14,fontWeight: FontWeight.w600,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway"
                                            )
                                          )
                                        ),
                                        SizedBox(height: 12,),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                  padding: EdgeInsets.only(top: 11,bottom: 12),
                                                  width: 123,
                                                  decoration: BoxDecoration(
                                                      border: Border(top: BorderSide(width: 0.5,color:Colors.black))
                                                  ),
                                                  child: Center(
                                                    child: Text("Нет",
                                                        style:TextStyle(fontSize: 12,fontWeight: FontWeight.w400,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway"
                                                        )
                                                    ),
                                                  )
                                              ),
                                              onTapDown: (_){
                                                Get.back();
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                  width: 123,
                                                  padding: EdgeInsets.only(top: 11,bottom: 12),
                                                  decoration: BoxDecoration(
                                                      border: Border(left:BorderSide(width: 0.5,color:Colors.black),top: BorderSide(width: 0.5,color:Colors.black))
                                                  ),
                                                  child:Center(
                                                    child:  Text("Да",
                                                        style:TextStyle(fontSize: 12,fontWeight: FontWeight.w400,height: 1.2,color: Color(0xffeb5757),letterSpacing: 0.5,fontFamily: "Relway"
                                                        )
                                                    ),
                                                  )
                                              ),
                                              onTapDown: (_){
                                                Get.back();Get.back();
                                              },
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                                )
                              )
                            )
                          );
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      allowImplicitScrolling: false,
                      physics: NeverScrollableScrollPhysics(),
                      controller: testController.controller,
                      children: [
                        StartPage(),
                        QuestionPage(),
                        FinishPage()
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }


}
