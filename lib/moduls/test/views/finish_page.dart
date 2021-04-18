import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/test/controller/test_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';

class FinishPage extends StatelessWidget{
  TestController testController =Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:52 ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${testController.correct.value} ",
                            style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,height: 1.2,color:
                                int.tryParse(testController.stat.data['test_result'][0]['answers_to_pass'])<=testController.correct.value? Color(0xff219653):Color(0xffEB5757),letterSpacing: 0.5,fontFamily: "Raleway")
                        ),
                        Text(
                            "из ${testController.list.length}",
                            style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 9,),
              Center(
                child: Text(
                    int.tryParse(testController.stat.data['test_result'][0]['answers_to_pass'])<=testController.correct.value?"Тест пройден":"Тест не пройден",
                    textAlign: TextAlign.center,
                    style:TextStyle(fontSize: 24,fontWeight: FontWeight.w800,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                ),
              ),
              SizedBox(height: 7,),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30 ),
                child: Center(
                  child: Text(
                      int.tryParse(testController.stat.data['test_result'][0]['answers_to_pass'])<=testController.correct.value
                          ?"Поздравляем Вас, вы успешно прошли курс «Научиться петь с нуля»! В любой момент вы можете проходить тест для поддержания знания."
                          :"Изучите не правильные ответы, которые находятся ниже и поробуйте еще раз! У вас должно получится, успехов Вам!",
                      textAlign: TextAlign.center,
                      style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Color(0xffF6F6F6),
            padding: EdgeInsets.all(23),
            height: 112,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                int.tryParse(testController.stat.data['test_result'][0]['answers_to_pass'])<=testController.correct.value?  GestureDetector(
                  child: Container(
                      height: 41,
                      padding: EdgeInsets.only(top: 11,bottom: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 0.5,color:Colors.black)
                      ),
                      child:Center(
                        child:  Text("Завершить",textAlign: TextAlign.center,
                            style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway"
                            )
                        ),
                      )
                  ),
                  onTapDown: (_){
                    Get.back();Get.back();
                  },
                ):Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: Get.width-107,
                          height: 41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 0.5,color:Colors.black)
                          ),
                          child:Center(
                            child:  Text("Завершить",
                                style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway"
                                )
                            ),
                          )
                      ),
                      onTapDown: (_){
                        Get.back();
                      },
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Container(
                          width: 41,
                          height: 41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 0.5,color:Colors.black)
                          ),
                          child:Center(
                            child: Icon(Icons.replay)
                          )
                      ),
                      onTapDown: (_){
                        Get.back(); Get.toNamed(Routes.TEST);
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ]
    );
  }
  
}