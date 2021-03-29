import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/dialog/atuhor.dart';
import 'package:new_school_official/dialog/treyler.dart';
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/course/controllers/course_controller.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/video/views/video_view.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:new_school_official/widgets/speackear.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class CourseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateCourse();
  }

}
class StateCourse extends State<CourseScreen>{
  CourseController _courseController =Get.put(CourseController());
  HomeController _homeController=Get.find();
  MainController _mainController = Get.find();
  @override
  void initState() {
    super.initState();
    initPre();
  }
  initPre()async{
    var  response=await Backend().getCourse(_courseController.id);
    print(response.headers);
    if(response.statusCode==200)
    {
      print(response.data);
      _homeController.course=response.data;
      response=await Backend().getVideos(_courseController.id);
      _homeController.videos=response.data;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.white
    // ));

    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: true,
          body:Obx(
                ()=>Container(
              color: Colors.white,
              child: _homeController.videos['lessons']!=null?ListView(
                padding: EdgeInsets.only(bottom: 20),
                children: [
                  Container(
                    width: Get.width,
                    height: 590,
                    child: Stack(
                      children: [
                        Image.network("${_homeController.course['kurses'][0]['banner_big']}",width: Get.width,height: 590,fit: BoxFit.cover,),
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
                                // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                //     statusBarColor: Colors.white,
                                //     statusBarIconBrightness: Brightness.dark,
                                //     statusBarBrightness: Brightness.dark,
                                //     systemNavigationBarColor: Colors.white
                                // ));
                                _homeController.videos={}.obs;
                                Get.back();

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
                                            '${_mainController.auth.value?"Продолжить":"Начать учиться"}',style: TextStyle(fontSize: 14,letterSpacing: 0.5,fontFamily: "Raleway",fontWeight: FontWeight.w400,color: Colors.white)
                                        ),
                                      ),
                                    ),
                                    onTap: ()async{
                                      if(_mainController.auth.value){
                                        if(_mainController.getUservideo_time.indexWhere((element) => element['course_id']==_courseController.id)>=0){
                                          var les=_homeController.videos['lessons'].where((element)=> (_mainController.getUservideo_time.where((ele)=>ele['lesson_id']==element['id']).length>0)).toList()[0];
                                          print(_homeController.videos['lessons'].where((element)=> (_mainController.getUservideo_time.where((ele)=>ele['lesson_id']==element['id']).length>0)).length);
                                          var index=_homeController.videos['lessons'].reversed.toList().indexWhere((el)=> les==el);
                                         print(_homeController.videos['lessons'].length-1-index);
                                          await Get.dialog(VideoScreen(les,index:index));
                                          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
                                          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                              statusBarColor: Colors.white,
                                              statusBarIconBrightness: Brightness.dark,
                                              statusBarBrightness: Brightness.dark,
                                              systemNavigationBarColor: Colors.white
                                          ));
                                          SystemChrome.setPreferredOrientations([

                                            DeviceOrientation.portraitUp,

                                          ]);
                                          setState(() {
                                          });
                                        }
                                      }else{
                                        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                        //     statusBarColor: Colors.white,
                                        //     statusBarIconBrightness: Brightness.dark,
                                        //     statusBarBrightness: Brightness.dark,
                                        //     systemNavigationBarColor: Colors.white
                                        // ));
                                        _mainController.widgets.removeAt(4);
                                        _mainController.widgets.add(RegisterPage());
                                        Get.dialog(Author());
                                      }
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
                                        onTap: ()async{

                                         await Get.dialog(TrailerScreen());
                                         SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
                                         SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                             statusBarColor: Colors.white,
                                             statusBarIconBrightness: Brightness.dark,
                                             statusBarBrightness: Brightness.dark,
                                             systemNavigationBarColor: Colors.white
                                         ));
                                         setState(() {

                                         });
                                        },
                                      ),
                                      _mainController.auth.value?SizedBox(width: 25,):Container(),
                                      _mainController.auth.value?Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/icons/Layer 16.svg",height: 15,width: 15,),
                                          SizedBox(width: 7,),
                                          Text("Загрузить",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,fontFamily: "Raleway",letterSpacing: 0.5,color: Colors.white),)
                                        ],
                                      ):Container()
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
                    margin: EdgeInsets.only(top: 22,bottom: 41),
                    height: 210,
                    width: Get.width,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: _homeController.videos['lessons'].length,
                      itemBuilder: (c,i){
                        if(i>0&&_mainController.auth.value==false) {
                          return GestureDetector(
                            key: ObjectKey(
                                "${_homeController.videos['lessons'].reversed.toList()[i]['video_image']}"
                            ),
                            child: Stack(
                                children:[
                                  Item(_homeController.videos['lessons'].reversed.toList()[i],false,_homeController,_mainController,i),
                                  Positioned(
                                      bottom: 80,
                                      right: 24,
                                      child: Image.asset("assets/images/padlock 1.png",width: 13,height: 16,)
                                  ),

                                ]
                            ),
                            onTap: (){
                              _mainController.widgets.removeAt(4);
                              _mainController.widgets.add(RegisterPage());
                              Get.dialog(Author());
                            },
                          );
                        } else{
                          var index_done=_mainController.getUservideo_time_all.indexWhere((element) => element['lesson_id']==_homeController.videos['lessons'][i]['id']);
                          if(index_done<0){
                           if(i!=0){
                             var last=_mainController.getUservideo_time_all.indexWhere((element) => element['lesson_id']==_homeController.videos['lessons'][i-1]['id']);
                             if(int.tryParse(_mainController.getUservideo_time_all[last]['done'])==0)
                             {
                               return GestureDetector(
                                 key: ObjectKey(
                                     "${_homeController.videos['lessons'].reversed.toList()[i]['video_image']}"
                                 ),
                                 child: Stack(
                                     children:[
                                       Item(_homeController.videos['lessons'].reversed.toList()[i],false,_homeController,_mainController,i),
                                       Positioned(
                                           bottom: 80,
                                           right: 24,
                                           child: Image.asset("assets/images/padlock 1.png",width: 13,height: 16,)
                                       ),

                                     ]
                                 ),
                                 onTap: (){
                                   _mainController.widgets.removeAt(4);
                                   _mainController.widgets.add(RegisterPage());
                                   Get.dialog(Author());
                                 },
                               );
                             }else{
                               return GestureDetector(
                                   key: ObjectKey(
                                       "${_homeController.videos['lessons'].reversed.toList()[i]['video_image']}"
                                   ),
                                   child: Item(_homeController.videos['lessons'].reversed.toList()[i],true,_homeController,_mainController,i),
                                   onTap:(){
                                   }
                               );
                             }
                           }
                          }else{
                            return GestureDetector(
                                key: ObjectKey(
                                    "${_homeController.videos['lessons'].reversed.toList()[i]['video_image']}"
                                ),
                                child: Item(_homeController.videos['lessons'].reversed.toList()[i],true,_homeController,_mainController,i),
                                onTap:(){

                                }
                            );
                          }

                        }
                      },
                    ),
                  ),
                  getMeterial(_homeController,_mainController),
                  getMDescription(_homeController),
                  getStatistik(),
                  getSpickers(_homeController)
                ],
              ):Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      )
    );
  }

  Widget getMeterial(_homeController,_mainController){
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,bottom:41 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Материалы",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
          SizedBox(height: 13,),
          ..._homeController.course['kurses'][0]['materials'].map((el)=>Container(
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
          Text("${el['material_name']}"
              ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
          _mainController.auth.value?SvgPicture.asset("assets/icons/down-arrow 1.svg"):Image.asset("assets/images/padlock 1_grey.png",height: 16,width: 16,)
        ],
      ),
    )).toList()

        ],
      ),
    );
  }

  Widget getMDescription(_homeController){
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
              SizedBox(height: 2,),
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
              SizedBox(height: 2,),
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
              SizedBox(height: 2,),
              Text(
                  "Тест"
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway"))
            ],
          )
        ],
      ),
    );
  }

  Widget getSpickers(_homeController){
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
                getSpicker(_homeController)
              ],
            ),
          )
        ],
      )
    );
  }
  Widget getSpicker(_homeController){
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
          GestureDetector(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${_homeController.course['kurses'][0]['spicker_name']}",maxLines:1
                  ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),
              SizedBox(height: 3,),
              Container(
                child: AutoSizeText("Подробнее",maxLines:1,textAlign: TextAlign.center
                      ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,letterSpacing: 0.5,color: Colors.black,fontFamily: "Raleway")),

              )
            ],),
            onTap: (){
              Get.bottomSheet(
                  SpeakerDialog(),
                  isScrollControlled: true
              );
            },)]
      ),
    );
  }
}

class Item extends StatefulWidget{
  var homeController;
  var lock;
  var index;
  var mainController;

  var lesson;

  Item(this.lesson, this.lock,this.homeController,this.mainController,this.index);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        image: DecorationImage(image: _image,fit: BoxFit.cover)
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  widget.mainController.auth.value? widget.lock?SvgPicture.asset("assets/icons/Layer 16.svg",color: Colors.black,width: 14,height: 14,):Opacity(opacity: 1,child: SvgPicture.asset("assets/icons/Layer 16.svg",color: Colors.black,width: 14,height: 14,),):Opacity(opacity: 1,child: SvgPicture.asset("assets/icons/Layer 16.svg",color: Colors.black,width: 14,height: 14,),)
                ],
              ),
            )
          ],
        ),
      onTap: ()async{
        if( widget.lock){
         await Get.dialog(VideoScreen(widget.lesson,index:widget.index));
         SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
         SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
             statusBarColor: Colors.white,
             statusBarIconBrightness: Brightness.dark,
             statusBarBrightness: Brightness.dark,
             systemNavigationBarColor: Colors.white
         ));
         SystemChrome.setPreferredOrientations([
           DeviceOrientation.portraitUp,
         ]);
         setState(() {
         });
        }
        else{
          widget.mainController.widgets.removeAt(4);
          widget.mainController.widgets.add(RegisterPage());
          Get.dialog(Author());
        }
      },
    );
  }

}