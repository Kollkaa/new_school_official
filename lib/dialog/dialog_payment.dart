import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';

import 'payment_web.dart';

class Payment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StatePayment();
  }

}
class StatePayment extends State<Payment>{
  MainController _mainController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 27,bottom: 40),
                              child:GestureDetector(
                                child: Row(
                                  children: [
                                    SizedBox(width: 15,),
                                    Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                                    SizedBox(width: 3,),
                                    Text(
                                      "Назад",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(bottom: 40,left: 23),
                              child: Text("Подключить",
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black,fontFamily: 'Raleway'),
                  ),
                            ),
                            Container(
                              margin:EdgeInsets.only(bottom: 40,left: 23),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Полный доступ к курсам",
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Raleway'),
    ),
                                  Text("Получите доступ ко всем курсам платформы",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Color(0xff434343),fontFamily: 'Raleway'),),


                                ],
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(bottom: 40,left: 23),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("7 дней бесплатно, далее 349 руб",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Raleway'),
                                      ),
                                  Text("В любой момент можно отключить подписку",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Color(0xff434343),fontFamily: 'Raleway'),),

                                ],
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(bottom: 40,left: 23),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Курсы выходят 2 раза в месяц",
                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: 'Raleway'),
                                  ),                                  Text("Все последующие курсы будут доступны",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Color(0xff434343),fontFamily: 'Raleway'),),

                                ],
                              ),
                            )
                          ]
                      )
                  ),
                  Column(
                      children: [
                      Container(
                          margin:EdgeInsets.only(bottom: 15,left: 23,right: 23),
                        child: GestureDetector(
                          child:  Container(
                            width: Get.width,
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black,width: 1)
                            ),
                            child: Center(
                              child: Text("Оформить подписку",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff434343),fontFamily: 'Raleway'),
                              ),
                            )
                          ),
                          onTapDown: (_){
                            Get.dialog(WebViewExample());
                            },
                        )
                      ),
                        Container(
                          margin:EdgeInsets.only(bottom: 29,left: 23,right: 23),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Продление подписки произойдет автоматически. Отменить подписку можно в любой момент в настройках. Платеж будет проведен через сервис ЮKassa. ваш платеж защищен в соответствии с международными стандартами безопасности.",
                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff434343),fontFamily: 'Raleway'),textAlign: TextAlign.justify,),

                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                              height: 44,
                              width: 165,
                              margin:EdgeInsets.only(bottom: 40,left: 23),
                              child: Image.asset("assets/images/Снимок экрана 2021-02-02 в 11.17 1.png")
                          ),
                        )
                      ]
                  )
                ]
            )
        )
    );
  }


}