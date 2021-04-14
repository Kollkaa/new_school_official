import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class TestController extends GetxController{
  MainController mainController=Get.find();
  HomeController homeController=Get.find();
  var currentIndexQuestion=0.obs;
  var controller=new PageController(initialPage: 0);
  var test;
  var stat;
  var correct=0.obs;

  double progress=0;

  var questionController=new PageController(initialPage: 0);

  var indexAnswer="".obs;

  Timer timer;
  @override
  void onInit() {
    getTest();
  }
  getTest()async{
    test=await Backend().getTestByidCourse(course_id: homeController.course['kurses'][0]['id']);
    stat=await Backend().getTestStat(id: mainController.profile['id'],course_id: homeController.course['kurses'][0]['id']);
    print(test.data);
    print(stat.data);

    Get.appUpdate();
  }
  @override
  void onReady() {}

  @override
  void onClose() {}

  void startTimer() {
   timer= new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) async{
            if (progress >= 1) {
              timer.cancel();
              print(test.data['questions'][currentIndexQuestion.value]['question_id']);
              if(indexAnswer.value!=""){
                var response= await Backend().sendQuery(question_id:test.data['questions'][currentIndexQuestion.value]['question_id'],answer_id:jsonDecode(indexAnswer.value)['answer_id'],id: mainController.profile['id'],course_id: homeController.course['kurses'][0]['id']);
                print(response);

                if(jsonDecode(indexAnswer.value)['correct']=="1"){
                  print('true');
                  correct.value+=1;
                  print(correct.value);
                }
              }
              if(currentIndexQuestion.value+1<test.data['questions'].length){
                indexAnswer.value="";
                currentIndexQuestion.value=currentIndexQuestion.value+1;
                questionController.jumpToPage(currentIndexQuestion.value);
                progress=1;
                Get.appUpdate();
                progress=0;
                Get.appUpdate();
                startTimer();
              }else{
                controller.jumpToPage(2);
              }
            } else {
              progress += 0.03;

            }
            Get.appUpdate();
          }

    );
  }
}