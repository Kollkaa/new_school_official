import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/course/views/course_view.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomeController _homeController =Get.put(HomeController());
  MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.light,  statusBarIconBrightness: Brightness.light,    statusBarColor: Colors.white,
        ));
    return Scaffold(
      appBar:                   AppBar(
        elevation: 0,
        leadingWidth: 90,
        leading: Row(
          children: [
            SizedBox(width: 15,),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/images/Group 242 (1).jpg"),
            ),
            SizedBox(
              width: 7,
            ),
            Text("Aidar",style: grey_text_title2,)
          ],
        ),
        actions: [
          Row(
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/settings.svg"),
              ),
              SizedBox(width: 15,),
            ],
          )
        ],
      ),
      backgroundColor: white_color,
      body: Column(
        children: [

          Expanded(
            child: ListView(
              children: [
                Obx(
                      ()=>_homeController.banner.value?Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _mainController.auth.value? Container(
                          padding: EdgeInsets.only(left: 15),
                          child:
                          Text("Продолжить",style: black_text_title,),

                        ):Container(),
                        _mainController.auth.value?Container(
                          margin: EdgeInsets.only(top: 7),
                          width: Get.width,
                          height: 223,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(width: 15,),
                              getItemContinuePlay("Как написать трек с нуля","gang6550.jpg"),
                              getItemContinuePlay("Как написать трек с нуля","gang6550.jpg"),
                              getItemContinuePlay("Как написать трек с нуля","gang6550.jpg"),
                            ],
                          ),
                        ):Container(
                          margin: EdgeInsets.only(top: 7,left: 15,right: 15),
                          width: Get.width-30,
                          height: 223,
                          child: Stack(
                            children: [
                              Container(
                                  width: Get.width-30,
                                  height: 223,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/images/Group 248.png",
                                        )
                                    ),
                                  )
                              ),
                              Positioned(top:11,right: 13,
                                  child: GestureDetector(
                                    child: SvgPicture.asset("assets/icons/close-3 1 (1).svg",height: 11,width: 11,),
                                    onTap: (){
                                      _homeController.banner.value=false;
                                    },
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Opacity(
                                    child: Text(
                                        'Учись новому!'
                                        ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.white,letterSpacing: 0.5,fontFamily: "Raleway")
                                    ),
                                    opacity: 0.7,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 13,right: 13,top: 7),
                                    width: Get.width,
                                    child:  AutoSizeText(
                                        'Обучайтесь без ограничений'.toUpperCase(),maxLines:1,minFontSize: 11,textAlign:TextAlign.center,
                                        style: TextStyle(fontSize: 15,letterSpacing: 0.5,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "Raleway")
                                    ),
                                  ),
                                  Opacity(
                                    child: GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 39,right: 39,top: 15),
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1,color: Colors.white),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(
                                          child: Text(
                                              'Начать учиться',style: TextStyle(fontSize: 14,letterSpacing: 0.5,fontWeight: FontWeight.w400,color: Colors.white,fontFamily: "Raleway")
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        Get.toNamed(Routes.VIDEO);
                                      },
                                    ),
                                    opacity: 0.7,
                                  ),
                                  SizedBox(height: 7,),
                                  Opacity(
                                    child:  Text(
                                        '30 дней бесплатно, далее 199 ₽ в месяц',style: TextStyle(fontSize: 9,fontWeight: FontWeight.w300,color: Colors.white,fontFamily: "Raleway",letterSpacing: 0.5)
                                    ),
                                    opacity: 0.7,
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
                ),

                Obx(
                        ()=>Container(
                      padding: EdgeInsets.only(top: 34),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child:
                            Text("Популярное",style: black_text_title,),

                          ),

                          Container(
                            margin: EdgeInsets.only(top: 7),
                            width: Get.width,
                            height: 142,
                            child:_homeController.news.length==0?ListView.builder(
                              itemCount: 4,
                              itemBuilder: (i,c){
                                return Container(
                                  margin: EdgeInsets.only(right: 12),
                                  height: 142,
                                  width: 216,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.black.withOpacity(0.04),
                                  ),);
                              },

                            ): ListView.builder(
                                padding: EdgeInsets.only(left: 15),

                                scrollDirection: Axis.horizontal,
                                itemCount: _homeController.popular.length,
                                itemBuilder: (c,i){
                                  return  Item("${_homeController.popular[i]['name']}","${_homeController.popular[i]['banner_small']}",_homeController.popular[i]['id'],_homeController,_mainController);
                                }
                            ),
                          )
                        ],
                      ),
                    )
                ),
                Obx(
                        ()=> Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child:
                            Text("Новое",style: black_text_title,),

                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            width: Get.width,
                            height: 142,
                            child:_homeController.news.length==0?ListView.builder(
                              itemCount: 4,
                              itemBuilder: (i,c){
                                return Container(
                                  margin: EdgeInsets.only(right: 12),
                                  height: 142,
                                  width: 216,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.black.withOpacity(0.04),
                                  ),);
                              },

                            ): ListView.builder(
                                padding: EdgeInsets.only(left: 15),
                                scrollDirection: Axis.horizontal,
                                itemCount: _homeController.news.length,
                                itemBuilder: (c,i){
                                  return  Item("${_homeController.news[i]['name']}","${_homeController.news[i]['banner_small']}",_homeController.popular[i]['id'],_homeController,_mainController);
                                }
                            ),
                          )
                        ],
                      ),
                    )
                ),
                Obx(
                        ()=>Container(
                      padding: EdgeInsets.only(top: 30,bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child:
                            Text("Категории",style: black_text_title,),

                          ),
                          Container(
                            margin: EdgeInsets.only(top: 7),
                            width: Get.width,
                            height: 142,
                            child: _homeController.categorise.length==0?ListView.builder(
                              itemCount: 4,
                              itemBuilder: (i,c){
                                return Container(
                                    margin: EdgeInsets.only(right: 12),
                                    height: 142,
                                    width: 142,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black.withOpacity(0.04),
                                    )
                                );
                              },

                            ): ListView.builder(
                                padding: EdgeInsets.only(left: 15),
                                scrollDirection: Axis.horizontal,
                                itemCount: _homeController.categorise.length,
                                itemBuilder: (c,i){
                                  return  ItemCat("${_homeController.categorise[i]['name']}","${_homeController.categorise[i]['image']}","${_homeController.categorise[i]['id']}",_homeController,_mainController);
                                }
                            ),
                          )
                        ],
                      ),
                    )
                ),

                // Container(
                //   padding: EdgeInsets.only(top: 30),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.only(left: 15),
                //         child:
                //         Text("Скоро",style: black_text_title,),
                //
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(top: 7),
                //         width: Get.width,
                //         height: 142,
                //         child: ListView(
                //           scrollDirection: Axis.horizontal,
                //           children: [
                //             SizedBox(width: 15,),
                //             getitemOtherCard("Как написать трек с нуля","gang6550.jpg"),
                //             getitemOtherCard("Как написать трек с нуля","1553478378-helen-mirren-504x796-instructor-tile_1x.jpg"),
                //             getitemOtherCard("Как написать трек с нуля","karusel.jpg"),
                //
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.only(top: 30,bottom: 30),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: EdgeInsets.only(left: 15),
                //         child:Text("Рекомендации",style: black_text_title,),
                //
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(top: 7),
                //         width: Get.width,
                //         height: 142,
                //         child: ListView(
                //           scrollDirection: Axis.horizontal,
                //           children: [
                //             SizedBox(width: 15,),
                //             getitemOtherCard("Как написать трек с нуля","1553478378-helen-mirren-504x796-instructor-tile_1x.jpg"),
                //             getitemOtherCard("Как написать трек с нуля","1553478378-helen-mirren-504x796-instructor-tile_1x.jpg"),
                //             getitemOtherCard("Как написать трек с нуля","1image2.png"),
                //
                //
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getItemContinuePlay(text,image){
    return  GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 223,
        width: 339,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black.withOpacity(0.04),
            image: DecorationImage(image: AssetImage("assets/images/${image}"),fit: BoxFit.fill)
        ),

        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(

                height: 50,
                width: 339,
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 25,right: 10,bottom: 12),
                child: AutoSizeText(
                  text,
                  style: white_title3_card_text_title,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            ),

            Positioned(
              bottom: 1,
              left: 6,
              child: Container(
                height: 4,
                width: Get.width*0.3,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      onTap: (){
      },
    );
  }



}
 class Item extends StatefulWidget{
  String text;
  String image;
  String id;
  var homeController;

  var mainController;
  Item(this.text, this.image, this.id,this.homeController,this.mainController);

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
       '${widget.image}',
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
       child: Container(
         margin: EdgeInsets.only(right: 12),
         height: 142,
         width: 216,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(10)),
             color: Colors.black.withOpacity(0.04),
             image: DecorationImage(image: _image,fit: BoxFit.cover)
         ),
         child: Stack(
           children: [

             Positioned(
               bottom: 0,
               child: Container(

                 height: 50,
                 width: 216,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     gradient: LinearGradient(
                         begin: Alignment.bottomCenter,
                         end: Alignment.topCenter,
                         colors: [Colors.black.withOpacity(1), Colors.black.withOpacity(0)]
                     )
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Container(
                       padding: EdgeInsets.only(left: 18,right: 10,bottom: 12),
                       child: AutoSizeText(
                         widget.text,
                         style: white_title2_card_text_title,
                         minFontSize: 10,
                         maxLines: 1,
                       ),
                     ),
                   ],
                 ),
               ),
             ),

           ],
         ),
       ),
       onTap: ()async{

         var response =await widget.homeController.getCourse(widget.id);
         SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

         Get.toNamed(Routes.COURSE);

       },
     );
   }

}

class ItemCat extends StatefulWidget{
  String text;
  String image;
  String id;
  HomeController homeController;

  var mainController;

  ItemCat(this.text, this.image,this.id,this.homeController,this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItemCat();
  }

}
class StateItemCat extends State<ItemCat>{

  var _image;
  bool _loading = true;

  @override
  void initState() {
    _image = new NetworkImage(
      '${widget.image}',
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
      width: 142,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.04),
      ),):
       GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 142,
        width: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black.withOpacity(0.04),
          image: DecorationImage(
            image: _image,
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: 142,
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
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Center(
                child: AutoSizeText(
                  widget.text,
                  style: white_title_card_text_title,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: ()async{
         await widget.homeController.getCoursesByCat(widget.id,widget.text);

      },
    );
  }

}


class ItemCont extends StatefulWidget{
  String text;
  String image;

  var homeController;

  var mainController;

  ItemCont(this.text, this.image,this.homeController,this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItemCont();
  }

}
class StateItemCont extends State<ItemCont>{

  var _image;
  bool _loading = true;

  @override
  void initState() {
    _image = new NetworkImage(
      '${widget.image}',
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
      width: 142,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.04),
      ),):
    GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 223,
        width: 339,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black.withOpacity(0.04),
            image: DecorationImage(image: AssetImage("assets/images/${widget.image}"),fit: BoxFit.fill)
        ),

        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(

                height: 50,
                width: 339,
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 25,right: 10,bottom: 12),
                child: AutoSizeText(
                  widget.text,
                  style: white_title3_card_text_title,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            ),

            Positioned(
              bottom: 1,
              left: 6,
              child: Container(
                height: 4,
                width: Get.width*0.3,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      onTap: (){
        widget.homeController.pageController.jumpToPage(1);
      },
    );
  }

}