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
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/search/controllers/search_controller.dart';
import 'package:new_school_official/moduls/static/controllers/static_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';
import 'package:new_school_official/widgets/speackear.dart';
import 'package:video_player/video_player.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  var items;
  @override
  void initState() {
    super.initState();
    if(_mainController.auth.value) {
      final barGroup1 = makeGroupData(0, 10, 15);
      final barGroup2 = makeGroupData(1, 15, 20);
      final barGroup3 = makeGroupData(2, 10, 15);
      final barGroup4 = makeGroupData(3, 10, 20);
      final barGroup5 = makeGroupData(4, 15, 20);
      final barGroup6 = makeGroupData(5, 10, 20);
      items = [
        barGroup1,
        barGroup2,
        barGroup3,
        barGroup4,
        barGroup5,
        barGroup6,
      ];
    }else{
      final barGroup1 = makeGroupData(0, 2.5, 2.5);
      final barGroup2 = makeGroupData(1, 2.5, 2.5);
      final barGroup3 = makeGroupData(2, 2.5, 2.5);
      final barGroup4 = makeGroupData(3, 2.5, 2.5);
      final barGroup5 = makeGroupData(4, 2.5, 2.5);
      final barGroup6 = makeGroupData(5, 2.5, 2.5);
      items = [
        barGroup1,
        barGroup2,
        barGroup3,
        barGroup4,
        barGroup5,
        barGroup6,
      ];
    }


    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_color,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top:0
          ),
          children:[
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42,
                  margin: EdgeInsets.only(
                      left: 20,right: 20, top:27
                  ),
                  child: Text("Статистика",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black,height: 1,fontFamily: 'Raleway'),)
              ),
              Container(
                  height: 53,

                  margin: EdgeInsets.only(
                      left: 20,right: 20,bottom: 12
                  ),
                  child: Text("Все обучение оцифрованно в разделе статистики. Доступно для зарегестрированного пользователя.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.black,height: 1,fontFamily: 'Raleway'),)
              ),
              _mainController.auth.value?Container():Container(
                margin: EdgeInsets.only(top: 7,left: 15,right: 15,bottom:57 ),
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
                            onTap: ()async{

                              _mainController.widgets.removeAt(4);
                              _mainController.widgets.add(RegisterPage());
                              _mainController.currentIndex.value=4;


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
              getStatistik(),
              getGraph(),
              getFinishedCourses(),
            ],
          ),
          ]
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
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 57),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value?9:0}"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Курса в процессе"
                  ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value?248:0}"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Часов обучено"
                  ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value?1:0}"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Colors.black)),
              SizedBox(height: 2,),

              Text(
                  "Курсов пройдено"
                  ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,letterSpacing: 0.5,color: Color(0xff666666)))
            ],
          )
        ],
      ),
    );
  }
  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];



    return [
      // Blue bars with a lighter center color.
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
      ),

    ];
  }
  Widget getGraph(){

    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 71),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("${_mainController.auth.value?"Завершенные курсы":"Предпочтения категорий"}",style: black_text_title),
          ),
          SizedBox(height: 21,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle,color: rightBarColor,size: 8,),
                  SizedBox(width: 6,),

                  Text("Прошли",style: TextStyle(fontFamily: 'Raleway',fontSize: 10,fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(width: 32,),
              Row(
                children: [
                  Icon(Icons.circle,color: leftBarColor,size: 8),
                  SizedBox(width: 6,),
                  Text("В процесссе",style: TextStyle(fontFamily: 'Raleway',fontSize: 10,fontWeight: FontWeight.w500),)
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
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: charts.BarChart(
                          _createSampleData(),
                          defaultRenderer: new charts.BarRendererConfig(
                              groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
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
          Text("Активность за последний год",style: black_text_title),
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
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
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