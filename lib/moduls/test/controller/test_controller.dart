import 'dart:async';
import 'dart:convert';
import 'dart:math';

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

  RxInt progress=60.obs;

  var questionController=new PageController(initialPage: 0);

  var indexAnswer="".obs;

  Timer timer;
  @override
  void onInit() {
    getTest();
  }

  getTest()async{
    test=await Backend().getTestByidCourse(course_id: homeController.course['kurses'][0]['id']);
    test.data['questions'];
    stat=await Backend().getTestStat(id: mainController.profile['id'],course_id: homeController.course['kurses'][0]['id']);
    print(test.data);
    print(stat.data);

    Get.appUpdate();
  }
  var list=[];
  randomizer(inte){
    list=[];
    while(list.length!=inte) {
        var question;
        do{
          var question = getRandomElement(test.data['questions']);
          if(!list.contains(question)){
            list.add(question);
          }
        }while (list.contains(question));
    }
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void startTimer() {
   timer= new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) async{
        print(progress.value);
            if (progress.value <= 0) {

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
                progress.value=0;
                Get.appUpdate();
                progress.value=60;
                Get.appUpdate();
                startTimer();
              }else{
                controller.jumpToPage(2);
              }
            } else {
              print(progress.value);

              progress.value =progress.value- 1;

            }
            Get.appUpdate();
          }

    );
  }
}