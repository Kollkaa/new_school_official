import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/dialog/treyler.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/search/controllers/search_controller.dart';
import 'package:new_school_official/moduls/static/controllers/static_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:new_school_official/widgets/speackear.dart';
import 'package:video_player/video_player.dart';

class StaticScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateStaticScreen();
  }

}
class StateStaticScreen extends State<StaticScreen>{
  StaticController searchController =Get.put(StaticController());
  HomeController _homeController =Get.find();
  MainController _mainController = Get.find();


  final Color leftBarColor = const Color(0xff9BA6FA);
  final Color rightBarColor = const Color(0xff6979F8);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 10, 15);
    final barGroup2 = makeGroupData(1, 15, 20);
    final barGroup3 = makeGroupData(2, 10, 15);
    final barGroup4 = makeGroupData(3, 10, 20);
    final barGroup5 = makeGroupData(4, 15, 20);
    final barGroup6 = makeGroupData(5, 10, 20);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: 20,right: 20,bottom: 33,
                    top:77
                ),
                child: Text("Статистика",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Raleway'),)
            ),
            getStatistik(),
            getGraph(),
            getFinishedCourses(),
          ],
        ),
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
      height: 68,
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 38),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "9"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Курса в процессе"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "248"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              Text(
                  "Часов обучено"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "1"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              Text(
                  "Курсов пройдено"
                  ,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }

  Widget getGraph(){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 71),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("Завершенные курсы",style: black_text_title),
          ),
          SizedBox(height: 21,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle,color: rightBarColor,size: 8,),
                  Text("Прошли",style: TextStyle(fontFamily: 'Raleway',fontSize: 12,fontWeight: FontWeight.w400))
                ],
              ),
              SizedBox(width: 32,),
              Row(
                children: [
                  Icon(Icons.circle,color: leftBarColor,size: 8),
                  Text("В процесссе",style: TextStyle(fontFamily: 'Raleway',fontSize: 12,fontWeight: FontWeight.w400),)
                ],
              )
            ],
          ),
          SizedBox(height: 21,),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              color: const Color(0xffffffff),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          BarChartData(
                            maxY: 20,

                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(
                                    color: Color(0xff999999), fontWeight: FontWeight.w400, fontSize: 11,fontFamily: 'Raleway'),
                                margin: 20,
                                getTitles: (double value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Музыка';
                                    case 1:
                                      return 'Спорт';
                                    case 2:
                                      return 'Наука';
                                    case 3:
                                      return 'Питание';
                                    case 4:
                                      return 'Кино';
                                    case 5:
                                      return 'Дизайн';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(
                                    color: Color(0xff999999), fontWeight: FontWeight.w400, fontSize: 11,fontFamily: 'Raleway'),
                                margin: 32,
                                reservedSize: 14,
                                getTitles: (value) {
                                  if (value == 0) {
                                    return '0';
                                  } else if (value == 5) {
                                    return '1 курс';
                                  }else if (value == 10) {
                                    return '2 курс';
                                  } else if (value == 15) {
                                    return '3 курс';
                                  } else if (value == 20) {
                                    return '4 курс';
                                  }  else {
                                    return '';
                                  }

                                },
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: showingBarGroups,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),)
        ],
      ),
    );
  }
  Widget getActivities(){

  }
  Widget getFinishedCourses(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:
          Text("Завершенные курсы",style: black_text_title),
        ),
        Container(
          padding: EdgeInsets.only(left: 20,right: 20),

          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: new ScrollController(keepScrollOffset: false),
            childAspectRatio: 166/109,
            children: [
              ...searchController.courses.map((el)=>Item("${el['topic']}","${el['banner_big']}","${el['id']}",_homeController,_mainController)),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
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