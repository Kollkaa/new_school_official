import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/dialog/treyler.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/search/controllers/search_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:new_school_official/widgets/speackear.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatelessWidget {
  SearchController searchController =Get.put(SearchController());
  HomeController _homeController =Get.find();
  MainController _mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_color,
      body: Container(
        padding: EdgeInsets.only(
          left: 16,right: 16,top: 57,

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                  left: 4,right: 4,bottom: 19
                ),
              child: Text("${searchController.title.toUpperCase()}",style: categoryTitle_text_style,)
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: new ScrollController(keepScrollOffset: false),
                childAspectRatio: 166/120,
                children: [
                  ...searchController.courses.map((el)=>Item("${el['topic']}","${el['banner_big']}","${el['id']}",_homeController,_mainController)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget getitemOtherCard(text,image){
    return  Container(
      margin: EdgeInsets.only(bottom: 9, left: 4,right: 4),

      height: 166/120*(Get.width-40)/2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue,
          image: DecorationImage(image: NetworkImage("${image}"),fit: BoxFit.cover)

      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,left: 0,right: 0,
            child: Container(
              height: 50,
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
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 12),
              child: AutoSizeText(
                text,
                style: TextStyle(color:white_color,fontSize: 9,fontWeight: FontWeight.w600,fontFamily: "Raleway",letterSpacing: 0.5),
                minFontSize: 10,
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
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
      margin: EdgeInsets.only(bottom: 9, left: 4,right: 4),

      height: 166/120*(Get.width-40)/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.04),
      ),):
    GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 9, left: 4,right: 4),
        height: 166/120*(Get.width-40)/2,
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
                width: (Get.width-60)/2,
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
        widget.homeController.pageController.jumpToPage(1);

      },
    );
  }

}