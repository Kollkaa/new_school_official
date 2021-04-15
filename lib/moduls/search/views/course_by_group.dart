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

class CourseByGroup extends StatelessWidget {
  SearchController searchController =Get.put(SearchController());
  HomeController _homeController =Get.find();
  MainController _mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 170,
        leading: GestureDetector(
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
      backgroundColor: white_color,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                  left: 12,right: 4,top: 27,
                ),
                child: Text("${searchController.title}",style: TextStyle(fontSize: 25,color: Color(0xff000000),fontWeight: FontWeight.w600,height: 1,fontFamily: "Raleway"),)
            ),
            Container(
              padding: EdgeInsets.only(
                left: 8,right: 8,top: 27,
              ),
              child:  GridView.count(
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
class StateItem extends State<Item> {

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
    return _loading ? Container(
      margin: EdgeInsets.only(bottom: 9, left: 4, right: 4),

      height: 166 / 120 * (Get.width - 40) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.04),
      ),) :
    GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 9, left: 4, right: 4),
        height: 166 / 120 * (Get.width - 40) / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black.withOpacity(0.04),
            image: DecorationImage(image: _image, fit: BoxFit.cover)
        ),
        child: Stack(
          children: [

            Positioned(
              bottom: 0,
              child: Container(

                height: 50,
                width: (Get.width - 60) / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0)
                        ]
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 18, right: 10, bottom: 12),
                      child: AutoSizeText(
                        widget.text,
                        style: TextStyle(fontSize: 7,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1,
                            fontFamily: "Raleway"),
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
      onTap: () async {
        var response = await widget.homeController.getCourse(widget.id);
        widget.homeController.pageController.jumpToPage(1);
      },
    );
  }

}