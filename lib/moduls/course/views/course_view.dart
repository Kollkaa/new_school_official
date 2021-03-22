import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/dialog/treyler.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/video/views/video_view.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:new_school_official/widgets/speackear.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class CourseScreen extends StatelessWidget {
  HomeController _homeController=Get.find();
  MainController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // transparent status bar
          systemNavigationBarColor: Colors.black, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // status bar icons' color
          systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
        ),
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: ListView(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  child: Stack(
                    children: [
                      Image.network("${_homeController.course['kurses'][0]['banner_big']}",width: Get.width,height: Get.height,fit: BoxFit.cover,),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: Get.width/1.5,
                          width: Get.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black.withOpacity(1), Colors.black.withOpacity(0)]
                              )
                          ),
                        ),
                      ),
                      Positioned(
                          top: 54,
                          left: 10,
                          child: GestureDetector(
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child:Opacity(
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,),
                                      Text("Назад",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w400,height: 1.2,color: Colors.white,letterSpacing: 0.5) ,)
                                    ],
                                  ),
                                  opacity: 0.8,
                                )
                            ),
                            onTap: (){
                              SystemChrome.setEnabledSystemUIOverlays(
                                  [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                              Get.back();
                              SystemChrome.setEnabledSystemUIOverlays(
                                  [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                            },
                          )
                      ),
                      Positioned(
                          top: 54,
                          right: 10,
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: SvgPicture.asset("assets/icons/share-3 1.svg"),
                            ),
                            onTap: (){
                              Share.share('https://mapus.com.ua/tasks/', subject: 'Share');
                            },
                          )
                      ),
                      Positioned(
                        bottom: 36,
                        right: 32,
                        left: 32,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                child: Text(
                                    'Пение',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.white,letterSpacing: 0.5)
                                ),
                                opacity: 0.8,
                              ),
                              Container(
                                width: Get.width,
                                child:  AutoSizeText(
                                    '${_homeController.course['kurses'][0]['topic']}',maxLines:1,minFontSize: 12,textAlign:TextAlign.center
                                    ,style: TextStyle(fontSize: 21,letterSpacing: 0.5,fontWeight: FontWeight.w900,color: Colors.white,fontFamily: "Raleway")
                                ),
                              ),
                              SizedBox(height: 17,),

                              Opacity(opacity: 0.7,
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Colors.white)
                                    ),
                                    child: Center(
                                      child: Text(
                                          'Начать учиться',style: TextStyle(fontSize: 14,letterSpacing: 0.5,fontFamily: "Raleway",fontWeight: FontWeight.w400,color: Colors.white)
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                  },
                                ),
                              ),
                              SizedBox(height: 12,),
                              Opacity(opacity: 0.8,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child:  Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          SvgPicture.asset("assets/icons/play-button-arrowhead-4 1.svg",color: Colors.white,),
                                          SizedBox(width: 7,),
                                          Text("Смотреть трейлер",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,fontFamily: "Raleway",letterSpacing: 0.5,color: Colors.white))
                                        ],
                                      ),
                                      onTap: (){
                                        Get.dialog(TrailerScreen());
                                      },
                                    ),
                                    SizedBox(width: 25,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/icons/Layer 16.svg",height: 15,width: 15,),
                                        SizedBox(width: 7,),
                                        Text("Загрузить",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,fontFamily: "Raleway",letterSpacing: 0.5,color: Colors.white),)
                                      ],
                                    )
                                  ],
                                ),)
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 22,bottom: 70),
                  height: 210,
                  width: Get.width,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: _homeController.videos['lessons'].length,
                    itemBuilder: (c,i){
                      if(i>0&&_mainController.auth.value==false) {
                        return Stack(
                            children:[
                              Item(_homeController.videos['lessons'].reversed.toList()[i],false,_homeController,_mainController),
                              Positioned(
                                  bottom: 80,
                                  right: 24,
                                  child: Image.asset("assets/images/padlock 1.png",width: 13,height: 16,)
                              ),

                            ]
                        );
                      } else{
                        return GestureDetector(
                            child: Item(_homeController.videos['lessons'].reversed.toList()[i],true,_homeController,_mainController),
                            onTap:(){

                            }
                        );
                      }
                    },
                  ),
                ),
                getMeterial(),
                getMDescription(),
                getStatistik(),
                getSpickers()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getItemLesson(lesson,lock){
    return  Container(
      margin: EdgeInsets.only(right: 12),
      width: 216,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 142,
            width: 216,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue,
                image: DecorationImage(image: NetworkImage("${lesson['video_image']}"),fit: BoxFit.fill)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:9),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width:190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("${lesson['video_name']}",minFontSize: 11 , maxLines: 2,style: TextStyle(fontSize: 12,fontFamily: "Raleway",letterSpacing: 0.5,fontWeight: FontWeight.w600,color: Colors.black),),
                      SizedBox(height: 2,),
                      AutoSizeText("${lesson['video_description']}",minFontSize: 8,maxLines:2,style: TextStyle(fontSize: 10,letterSpacing: 0.5,fontWeight: FontWeight.w300
                          ,color: Colors.black,fontFamily: "Raleway",fontStyle: FontStyle.normal),),
                    ],
                  ),
                ),
                lock?SvgPicture.asset("assets/icons/Layer 16.svg",color: Colors.black,width: 14,height: 14,):Container()
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget getMeterial(){
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,bottom:71 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Материалы",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
          SizedBox(height: 13,),
          _homeController.course['kurses'][0]!=null? Container(
            width: Get.width,
            height: 45.0*_homeController.course['kurses'][0]['materials'].length,
            child: ListView.builder(
                itemCount: _homeController.course['kurses'][0]['materials'].length,
                itemBuilder:(c,i){
                  return Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 17),

                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,color: Color(0xffECECEC)
                            )
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_homeController.course['kurses'][0]['materials'][i]['material_name']}"
                            ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
                        _mainController.auth.value?SvgPicture.asset("assets/icons/down-arrow 1.svg"):Image.asset("assets/images/padlock 1_grey.png",height: 16,width: 16,)
                      ],
                    ),
                  );
                } ),
          ):Container()

        ],
      ),
    );
  }

  Widget getMDescription(){
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,bottom:28 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Описание",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
          SizedBox(height: 4,),
          Container(
            padding: EdgeInsets.only(bottom: 5),

            child: Text("${_homeController.course['kurses'][0]['description_short']}"
                ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,letterSpacing: 0.5,height:1.5,color: Colors.black,fontFamily: "Raleway")),
          ),


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
      height: 95,
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 71),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "9"
                  ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
              Text(
                  "Уроков"
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway"))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "248"
                  ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
              Text(
                  "Минут"
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway"))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "1"
                  ,style: TextStyle(fontSize: 23,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
              Text(
                  "Тест"
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway"))
            ],
          )
        ],
      ),
    );
  }

  Widget getSpickers(){
    return Container(
      margin: EdgeInsets.only(left: 18,bottom: 57),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Спикеры",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
          SizedBox(height: 23),
          Container(
            width: Get.width,
            height: 194,
              child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                getSpicker()
              ],
            ),
          )
        ],
      )
    );
  }
  Widget getSpicker(){
    return Container(
      width: 175,
      child: Column(

        children: [
          Container(
            height: 135,
            width: 135,
            decoration:BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage("${_homeController.course['kurses'][0]['spicker_image']}"),fit: BoxFit.cover)

            ),
          ),
          SizedBox(height: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text("${_homeController.course['kurses'][0]['spicker_name']}",maxLines:1
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
              Container(
                child:GestureDetector(
                  child: AutoSizeText("Подробнее",maxLines:1,textAlign: TextAlign.center
                      ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
                  onTap: (){
                    Get.bottomSheet(
                        SpeakerDialog(),
                        isScrollControlled: true
                    );
                  },
                )
              )
            ],
          )

        ],
      ),
    );
  }
}

class Item extends StatefulWidget{
  var homeController;
  var lock;

  var mainController;

  var lesson;

  Item(this.lesson, this.lock,this.homeController,this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItem();
  }

}
class StateItem extends State<Item>{

  var _image;
  bool _loading = true;


  @override
  void initState() {
    _image = new NetworkImage(
      '${widget.lesson['video_image']}',
    );
    _image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, call) {
          if (mounted) {
            setState(() {
              _loading = false;
            });
          }
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _loading ?Container(
      margin: EdgeInsets.only(right: 12),
      height: 142,
      width: 216,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.04),
      ),):
    GestureDetector(
        child:Column(
          children: [
            Container(
              height: 142,
              width: 216,
              child:  Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 142,
                    width: 216,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black.withOpacity(0.04),
                        image: DecorationImage(image: _image,fit: BoxFit.fill)
                    ),),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: 196,
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:9),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("${widget.lesson['video_name']}",minFontSize: 11 , maxLines: 2,style: TextStyle(fontSize: 12,fontFamily: "Raleway",letterSpacing: 0.5,fontWeight: FontWeight.w600,color: Colors.black),),
                        SizedBox(height: 2,),
                        AutoSizeText("${widget.lesson['video_description']}",minFontSize: 8,maxLines:2,style: TextStyle(fontSize: 10,letterSpacing: 0.5,fontWeight: FontWeight.w300
                            ,color: Colors.black,fontFamily: "Raleway",fontStyle: FontStyle.normal),),
                      ],
                    ),
                  ),
                  widget.lock?SvgPicture.asset("assets/icons/Layer 16.svg",color: Colors.black,width: 14,height: 14,):Container()
                ],
              ),
            )
          ],
        ),
      onTap: (){
        Get.dialog(VideoScreen(widget.lesson));
      },
    );
  }

}