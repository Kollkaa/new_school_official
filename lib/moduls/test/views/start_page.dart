import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/test/controller/test_controller.dart';
import 'package:new_school_official/service/backend.dart';

class StartPage extends StatelessWidget{
  TestController testController =Get.find();
  @override
  Widget build(BuildContext context) {
    return testController.test!=null?Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top:49 ),
                child: Center(
                  child: Text(
                      "Тест",
                      style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top:136,left: 55,right: 55 ),
                  child: Column(
                    children: [
                      Container(
                        height:70,
                        width:70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    testController.homeController.course['kurses'][0]['banner_big']
                                )
                            )
                        ),
                      ),
                      SizedBox(height: 13,),
                      Text(
                          "${testController.homeController.course['kurses'][0]['topic']}",textAlign: TextAlign.center,
                          style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                      ),
                      SizedBox(height: 3,),
                      Text(
                          "Чтобы сдать тест, нужно ответить на ${testController.stat.data['test_result'][0]['answers_to_pass']} из ${testController.test.data['questions'].length} вопросов",textAlign: TextAlign.center,
                          style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Raleway")
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(20),
            child:        FlatButton(
            padding: EdgeInsets.all(1),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black,width: 1)
              ),
              height: 41,
              width: Get.width,
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Начать тестирование",
                          style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1.2,color: Color(0xff434343),letterSpacing: 0.5,fontFamily: "Raleway")
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.arrow_forward,size: 10,)
                    ],
                  )
              ),
            ),
            onPressed: ()async{
              testController.randomizer(5);
              print(testController.list.length);
               var response =await Backend().startTest(id: testController.mainController.profile['id'],course_id: testController.homeController.course['kurses'][0]['id']);
              print(response.data);
               testController.controller.jumpToPage(1);
               testController.startTimer();

            },
          )

        )
      ],
    ):Center(child: CircularProgressIndicator(),);
  }

}