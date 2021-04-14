import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/test/controller/test_controller.dart';
import 'package:new_school_official/service/backend.dart';

class QuestionPage extends StatelessWidget{
  TestController testController =Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Container(
                  margin: EdgeInsets.only(top:28 ),
                  child: Center(
                    child: Text(
                        "${testController.currentIndexQuestion.value+1} из ${testController.test.data['questions'].length}",
                        style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway")
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top:28 ),
                  child: Center(
                    child: Text(
                        "30с",
                        style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway")
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Container(
                  height: 10,width: 109,
                  margin: EdgeInsets.only(top:28 ),
                  child:_LinearProgressIndicatorApp(testController.progress,testController.startTimer),
                ),
                SizedBox(width: 20,),
              ],
            )
          ],
        ),
        Expanded(
          child: PageView(
            physics:new NeverScrollableScrollPhysics(),
            controller: testController.questionController,
            children: [
              ...testController.test.data['questions'].map((el)=>Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(el['question'].toString(),
                        style:TextStyle(fontSize: 19,fontWeight: FontWeight.w700,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway")
                    ),
                    ...el['answers'].map((answer)=>GestureDetector(
                      child: Obx(
                            ()=>Container(
                          width: Get.width,
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.all(12),
                          height: 41,
                          decoration: BoxDecoration(
                              border: testController.indexAnswer.value==jsonEncode(answer)?Border.all(width: 1,color: Color(0xff408F4D)):Border.all(width: 1,color: Color(0xffE6E6E6)),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text("${answer['answer']}",
                              style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,height: 1.2,color: Colors.black,letterSpacing: 0.5,fontFamily: "Relway")
                          ),
                        ),
                      ),
                      onTapDown: (_){
                        print(jsonDecode(jsonEncode(answer))['answer']);

                        testController.indexAnswer.value=jsonEncode(answer);
                      },
                    )).toList()
                  ],
                ),
              )).toList()
            ],
          )
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black,width: 1)
            ),
            height: 41,
            width: Get.width,
            child: Center(
              child: Text(
                  "Ответить →",
                  style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1.2,color: Color(0xff434343),letterSpacing: 0.5,fontFamily: "Relway")
              ),
            ),
          ),
          onTapDown: (_)async{
            if(testController.indexAnswer.value!=""){
              testController.timer.cancel();
              print(testController.test.data['questions'][testController.currentIndexQuestion.value]['question_id']);
              var response= await Backend().sendQuery(question_id:testController.test.data['questions'][testController.currentIndexQuestion.value]['question_id'],answer_id:jsonDecode(testController.indexAnswer.value)['answer_id'],id: testController.mainController.profile['id'],course_id: testController.homeController.course['kurses'][0]['id']);
              print(response);
              if(jsonDecode(testController.indexAnswer.value)['correct']=="1"){
                print('true');
                testController.correct.value+=1;
                print(testController.correct.value);

              }
              if(testController.currentIndexQuestion.value+1<testController.test.data['questions'].length) {
                testController.indexAnswer.value = "";
                testController.currentIndexQuestion.value =
                    testController.currentIndexQuestion.value + 1;
                testController.questionController.jumpToPage(
                    testController.currentIndexQuestion.value);
                testController.progress = 1;
                Get.appUpdate();
                testController.progress = 0;
                Get.appUpdate();
                testController.startTimer();
              }else{
                testController.controller.jumpToPage(2);
              }
            }else{
              Get.snackbar("", "Выберите один с ответов");
            }
          },
        )
      ],
    );
  }

}
class _LinearProgressIndicatorApp extends StatefulWidget {
  double progress;
  Function startTimer;
  _LinearProgressIndicatorApp(this.progress,this.startTimer);

  @override
  State<StatefulWidget> createState() {
    return _LinearProgressIndicatorAppState();
  }
}

class _LinearProgressIndicatorAppState
    extends State<_LinearProgressIndicatorApp> {


  @override
  void initState() {
    widget.startTimer();
  }



  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.green.withOpacity(0.12),
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
      value: widget.progress,
    );
  }
}