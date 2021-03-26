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

import 'dialog_count.dart';
const Color blueColor = Color(0xff1565C0);
const Color orangeColor = Color(0xffFFA000);

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
   List<charts.Series> seriesList;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
   bool animate;

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
  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      OrdinalSales('Музыка', 0),
      OrdinalSales('Спорт', 3),
      OrdinalSales('Наука', 1),
      OrdinalSales('Питание', 1),
      OrdinalSales('Кино', 3),
      OrdinalSales('Дизайн', 4),
    ];

    final tabletSalesData = [
      OrdinalSales('Музыка', 0),
      OrdinalSales('Спорт', 4),
      OrdinalSales('Наука', 2),
      OrdinalSales('Питание', 1),
      OrdinalSales('Кино', 3),
      OrdinalSales('Дизайн', 4),
    ];

    return [
      charts.Series<OrdinalSales, String>(
          id: 'expense',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(leftBarColor),
          labelAccessorFn: (OrdinalSales sales, _) =>
          'expense: ${sales.sales.toString()}',
          displayName: "Expense"),
      charts.Series<OrdinalSales, String>(
        id: 'income',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(rightBarColor),
        displayName: "Income",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
  List<charts.Series<OrdinalSales, String>> _createSampleDataAuth() {

   final desktopSalesData= _homeController.categorise.map((element) {

     if(_mainController.getStats['courses_ended'].indexWhere((el) => element['id']==el['category'])>0){
       return OrdinalSales(element['name'], _mainController.getStats['courses_ended'][_mainController.getStats['courses_ended'].indexWhere((el) => element['id']==el['category'])]['count']<=1?3:_mainController.getStats['courses_ended'][_mainController.getStats['courses_ended'].indexWhere((el) => element['id']==el['category'])]['count']);
     }else{
       return OrdinalSales(element['name'], 1 );
   }
  }
   ).toList();
   // _mainController.getStats['courses_ended'].map(
   //      (el)=>      OrdinalSales(
   //          _homeController.categorise[_homeController.categorise.indexWhere((element) => element['id']==el['category'])]['name']
   //          , el['count']),
   //
   // );
    final desktopSalesData1 = [
      OrdinalSales('Музыка', 0),
      OrdinalSales('Спорт', 3),
      OrdinalSales('Наука', 1),
      OrdinalSales('Питание', 1),
      OrdinalSales('Кино', 3),
      OrdinalSales('Дизайн', 4),
    ];

   final tabletSalesData= _homeController.categorise.map((element) {

     if(_mainController.getStats['courses_in_progress'].indexWhere((el) => element['id']==el['category'])>0){
       print(element);

       return OrdinalSales(element['name'], _mainController.getStats['courses_in_progress'][_mainController.getStats['courses_in_progress'].indexWhere((el) => element['id']==el['category'])]['count']<=1?4:_mainController.getStats['courses_in_progress'][_mainController.getStats['courses_in_progress'].indexWhere((el) => element['id']==el['category'])]['count'] );
     }else{
       return OrdinalSales(element['name'], 1 );
     }
   }
   ).toList();

    return [
      charts.Series<OrdinalSales, String>(
          id: 'expense',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(leftBarColor),
          labelAccessorFn: (OrdinalSales sales, _) =>
          'expense: ${sales.sales.toString()}',
          displayName: "Expense"),
      charts.Series<OrdinalSales, String>(
        id: 'income',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(rightBarColor),
        displayName: "Income",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
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
                  margin: EdgeInsets.only(
                      left: 20,right: 20, top:27
                  ),
                  child: Text("Статистика",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black,height: 1,fontFamily: 'Raleway'),)
              ),
              _mainController.auth.value?Container():Container(
                  height: 53,

                  margin: EdgeInsets.only(
                    top: 10,
                      left: 20,right: 20
                  ),
                  child: Text("Все обучение оцифрованно в разделе статистики. Доступно для зарегестрированного пользователя.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.black,height: 1.5,fontFamily: 'Raleway'),)
              ),
              _mainController.auth.value?Container():Container(
                margin: EdgeInsets.only(top: 7,left: 15,right: 15 ),
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
              _mainController.auth.value?getStatistikAuth():getStatistik(),
              _mainController.auth.value?getGraphAuth():getGraph(),
              getActivities(),
              _mainController.auth.value?getFinishedCourses():Container(),
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
      margin: EdgeInsets.only(top:_mainController.auth.value?27:57,left: 20,right: 20,bottom: 57),
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
  Widget getStatistikAuth(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              width: 1,color: Color(0xffECECEC)
          )
      ),
      height: 68,
      margin: EdgeInsets.only(top:_mainController.auth.value?27:57,left: 20,right: 20,bottom: 57),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.getStats['coursesStarted']}"
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
                  "${_mainController.getStats['lessonsHours']}"
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
                  "${_mainController.getStats['coursesEnded']}"
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

  Widget getGraph(){
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 57),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("Предпочтения категорий",style: black_text_title),
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
                      child: charts.BarChart(
                        _createSampleData(),
                        animate: animate,

                        domainAxis: new charts.OrdinalAxisSpec(
                            renderSpec: new charts.SmallTickRendererSpec(

                              // Tick and Label styling here.
                                labelStyle: new charts.TextStyleSpec(
                                    fontSize: 8, // size in Pts.
                                    color: charts.Color(
                                        r: 153,
                                        g: 153,
                                        b: 153
                                    )),
                                // Change the line colors to match text color.
                                lineStyle: charts.LineStyleSpec(
                                  thickness: 1,
                                  color: charts.Color(
                                      r: 228,
                                      g: 228,
                                      b: 228,
                                  ),
                                ))),

                        barGroupingType: charts.BarGroupingType.grouped,
                        defaultRenderer: charts.BarRendererConfig(
                            cornerStrategy: const charts.ConstCornerStrategy(50)),

                        primaryMeasureAxis: charts.NumericAxisSpec(
                          renderSpec: new charts.GridlineRendererSpec(

                            // Tick and Label styling here.
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 8, // size in Pts.
                                  color: charts.Color(
                                    r: 153,
                                    g: 153,
                                    b: 153,

                                  )),

                              // Change the line colors to match text color.
                              lineStyle: charts.LineStyleSpec(
                                thickness: 1,
                                color: charts.Color(
                                  r: 228,
                                  g: 228,
                                  b: 228,
                              ),
                              )),
                            tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              desiredMinTickCount: 5,
                            ),
                            tickFormatterSpec: charts.BasicNumericTickFormatterSpec((num value) {
                              var index = value.floor();
                              return '$index курс';
                            })
                        ),
                        secondaryMeasureAxis: null,

                      )
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
  Widget getGraphAuth(){

    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 57),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("Предпочтения категорий",style: black_text_title),
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
                        child: charts.BarChart(
                          _createSampleDataAuth(),
                          animate: animate,

                          domainAxis: new charts.OrdinalAxisSpec(
                              renderSpec: new charts.SmallTickRendererSpec(
                                  labelRotation: 45,

                                // Tick and Label styling here.
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 8, // size in Pts.
                                      color: charts.Color(
                                          r: 153,
                                          g: 153,
                                          b: 153
                                      )),
                                  // Change the line colors to match text color.
                                  lineStyle: charts.LineStyleSpec(
                                    thickness: 1,
                                    color: charts.Color(
                                      r: 228,
                                      g: 228,
                                      b: 228,
                                    ),
                                  ))),

                          barGroupingType: charts.BarGroupingType.grouped,
                          defaultRenderer: charts.BarRendererConfig(
                              cornerStrategy: const charts.ConstCornerStrategy(50)),

                          primaryMeasureAxis: charts.NumericAxisSpec(
                              renderSpec: new charts.GridlineRendererSpec(

                                // Tick and Label styling here.
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 8, // size in Pts.
                                      color: charts.Color(
                                        r: 153,
                                        g: 153,
                                        b: 153,

                                      )),

                                  // Change the line colors to match text color.
                                  lineStyle: charts.LineStyleSpec(
                                    thickness: 1,
                                    color: charts.Color(
                                      r: 228,
                                      g: 228,
                                      b: 228,
                                    ),
                                  )),
                              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                                desiredMinTickCount: 5,
                              ),
                              tickFormatterSpec: charts.BasicNumericTickFormatterSpec((num value) {
                                var index = value.floor();
                                return '$index курс';
                              })
                          ),
                          secondaryMeasureAxis: null,

                        )
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:
          Text("Активность за последний год",style: black_text_title),
        ),
        Container(
          padding: EdgeInsets.only(top:2,left: 20,right: 20,bottom: 30),

          child: Row(
            children: [
              Text("15 дней без перерыва   ",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: Color(0xff6A6A6A),fontFamily: "Raleway"),),
              Container(
                width: 1,height: 23,color: Color(0xffc4c4c4),
              ),
              Text("   Всего 123 дня",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500,color: Color(0xff6A6A6A),fontFamily: "Raleway"))
            ],
          ),
        ),
        Container(
          height: 167,
          width: Get.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 76,
                  height: 170,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 4,
                          children: [
                            GestureDetector(
                              child:                             Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                                onTap: (){
                                showDialog(context: context
                                ,child:CountVideoOnDay()
                                );
                                },
                            ),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),

                          ],
                        ),
                      ),
                      SizedBox(height: 13,),

                      Text("Ноябрь",style: TextStyle(fontSize: 9,color: Color(0xff6a6a6a),fontWeight: FontWeight.w400,letterSpacing: 0.5,fontFamily: "Raleway"))
                    ],
                  ),
                ),
                SizedBox(width: 13,),

                Container(
                  width: 76,
                  height: 170,
                  child:Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 4,
                          children: [
                            Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),

                          ],
                        ),
                      ),
                      SizedBox(height: 13,),

                      Text("Декабрь",style: TextStyle(fontSize: 9,color: Color(0xff6a6a6a),fontWeight: FontWeight.w400,letterSpacing: 0.5,fontFamily: "Raleway"))
                    ],
                  ),
                ),
                SizedBox(width: 13,),

                Container(
                  width: 76,
                  height: 170,
                  child:Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 4,
                          children: [
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),

                          ],
                        ),
                      ),
                      SizedBox(height: 13,),

                      Text("Январь",style: TextStyle(fontSize: 9,color: Color(0xff6a6a6a),fontWeight: FontWeight.w400,letterSpacing: 0.5,fontFamily: "Raleway"))
                    ],
                  ),
                ),
                SizedBox(width: 13,),

                Container(
                  width: 76,
                  height: 170,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 4,
                          children: [
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),

                          ],
                        ),
                      ),
                      SizedBox(height: 13,),

                      Text("Февраль",style: TextStyle(fontSize: 9,color: Color(0xff6a6a6a),fontWeight: FontWeight.w400,letterSpacing: 0.5,fontFamily: "Raleway"))
                    ],
                  ),
                ),
                SizedBox(width: 13,),

                Container(
                  width: 76,
                  height: 170,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          crossAxisCount: 4,
                          children: [
                            Container(width: 16,height: 16,color: Color(0xff2F80ED),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),
                            Container(width: 16,height: 16,color: Color(0xffF2F2F2),),

                          ],
                        ),
                      ),
                      SizedBox(height: 13,),
                      Text("Март",style: TextStyle(fontSize: 9,color: Color(0xff6a6a6a),fontWeight: FontWeight.w400,letterSpacing: 0.5,fontFamily: "Raleway"))
                    ],
                  ),
                ),
                SizedBox(width: 20,),

              ],
            ),
          ),
        ),
        SizedBox(
          height: 57,
        )
      ],
    );
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
          padding: EdgeInsets.only(left: 4,right: 4,top: 13),
          width: Get.width,
          height: 142,
          child: _homeController.news.length==0?ListView.builder(
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
        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //     statusBarIconBrightness: Brightness.light,
        //     statusBarBrightness: Brightness.light,
        //     systemNavigationBarColor: Colors.white
        // ));
        Get.toNamed(Routes.COURSE,arguments:widget.id);
        widget.homeController.videos={}.obs;
      },
    );
  }

}
