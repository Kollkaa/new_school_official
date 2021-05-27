import 'package:auto_size_text/auto_size_text.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dio/dio.dart' as dios;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/custom/loader.dart';
import 'package:new_school_official/dialog/dialog_payment.dart';
import 'package:new_school_official/moduls/auth/views/register.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/static/controllers/static_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

const Color blueColor = Color(0xff1565C0);
const Color orangeColor = Color(0xffFFA000);

class StaticScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateStaticScreen();
  }

}

class StateStaticScreen extends State<StaticScreen> {
  final GetStorage box = GetStorage();

  StaticController searchController = Get.put(StaticController());

  HomeController _homeController = Get.find();

  MainController _mainController = Get.find();

  List<charts.Series> seriesList;

  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  bool animate;

  final Color leftBarColor = const Color(0xff9BA6FA);

  final Color rightBarColor = const Color(0xff6979F8);

  final double width = 7;


  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      OrdinalSales('Музыка', 0),
      OrdinalSales('Спорт', 0),
      OrdinalSales('Наука', 0),
      OrdinalSales('Питание', 0),
      OrdinalSales('Кино', 0),
      OrdinalSales('Дизайн', 0),
    ];

    final tabletSalesData = [
      OrdinalSales('Музыка', 0),
      OrdinalSales('Спорт', 0),
      OrdinalSales('Наука', 0),
      OrdinalSales('Питание', 0),
      OrdinalSales('Кино', 0),
      OrdinalSales('Дизайн', 0),
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
      )
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

  List<charts.Series<OrdinalSales, String>> _createSampleDataAuth() {
    final tabletSalesData = _homeController.categorise.map((element) {
      if (_mainController.getStats['courses_ended'].indexWhere((
          el) => element['id'] == el['category']) >= 0) {
        return OrdinalSales(element['name'],
            (_mainController.getStats['courses_ended'][_mainController
                .getStats['courses_ended'].indexWhere((el) =>
            element['id'] == el['category'])]['count']));
      } else {
        return OrdinalSales(element['name'], 0);
      }
    }
    ).toList();

    final desktopSalesData = _homeController.categorise.map((element) {
      if (_mainController.getStats['courses_in_progress'].indexWhere((
          el) => element['id'] == el['category']) >= 0) {
        return OrdinalSales(element['name'],
            _mainController.getStats['courses_in_progress'][_mainController
                .getStats['courses_in_progress'].indexWhere((
                el) => element['id'] == el['category'])]['count']);
      } else {
        return OrdinalSales(element['name'], 0);
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
          labelAccessorFn: (OrdinalSales sales, _) =>
          'expense: ${sales.sales.toString()}',
          displayName: "Expense")
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

  @override
  void initState() {
    super.initState();
    initStat();
  }

  @override
  Widget build(BuildContext context) {
    return _mainController.auth.value &&
        _mainController.getStats['courses_in_progress'] == null
        ? Loader()
        : Scaffold(
      backgroundColor: white_color,
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.only(
                top: 0
            ),
            children: [
            Obx(
            ()=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 27
                      ),
                      child: Text("Статистика", style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1,
                          fontFamily: 'Raleway'),)
                  ),
                  _mainController.auth.value ? Container() : Container(
                      height: 53,

                      margin: EdgeInsets.only(
                          top: 10,
                          left: 20, right: 20
                      ),
                      child: Text(
                        "Все обучение оцифрованно в разделе статистики. Доступно для зарегестрированного пользователя.",
                        style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            height: 1.5,
                            fontFamily: 'Raleway'),)
                  ),
                  SizedBox(height: 20.0),
                  _mainController.profile['subscriber'] == '1' || !_mainController.banner.value
                      ? Container()
                      :  Container(
                    margin: EdgeInsets.only(top: 7, left: 15, right: 15),
                    width: Get.width - 30,
                    height: 223,
                    child: Stack(
                        children: [
                          Container(
                              width: Get.width - 30,
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
                          Positioned(top: 11, right: 13,
                              child: GestureDetector(
                                child: SvgPicture.asset(
                                  "assets/icons/close-3 1 (1).svg", height: 11,
                                  width: 11,),
                                onTap: () {
                                  _mainController.banner.value = false;
                                },
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                child: Text(
                                    'Учись новому!'
                                    , style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontFamily: "Raleway")
                                ),
                                opacity: 0.7,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 13, right: 13, top: 7),
                                width: Get.width,
                                child: AutoSizeText(
                                    'Обучайтесь без ограничений'.toUpperCase(),
                                    maxLines: 1,
                                    minFontSize: 11,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Raleway")
                                ),
                              ),
                              Opacity(
                                child: GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 39, right: 39, top: 15),
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text(
                                          'Начать учиться', style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: "Raleway")
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (!_mainController.auth.value) {
                                      Get.to(RegisterPage(true), duration: Duration());
                                    } else {
                                      Get.to(
                                          Payment(
                                            subscriber: _mainController
                                                .profile['subscriber'],
                                          ),
                                          duration: Duration());
                                    }
                                  },
                                ),
                                opacity: 0.7,
                              ),
                              SizedBox(height: 7,),
                              Opacity(
                                child: Text(
                                    '30 дней бесплатно, далее 199 ₽ в месяц',
                                    style: TextStyle(fontSize: 9,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontFamily: "Raleway",
                                        letterSpacing: 0.5)
                                ),
                                opacity: 0.7,
                              ),

                            ],
                          )
                        ],

                  ),
                      ),
                  _mainController.auth.value
                      ? getStatistikAuth()
                      : getStatistik(),
                  _mainController.auth.value ? getGraphAuth() : getGraph(),
                  _mainController.auth.value
                      ? getActivitiesAuth()
                      : getActivities(),
                  _mainController.auth.value
                      ? getFinishedCourses()
                      : Container(),
                ],
              ),),
            ]
        ),
      ),
    );
  }

  Widget getStatistik() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              width: 1, color: Color(0xffECECEC)
          )
      ),
      height: 68,
      margin: EdgeInsets.only(top: _mainController.auth.value ? 27 : 57,
          left: 20,
          right: 20,
          bottom: 57),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value ? 9 : 0}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Курса в процессе"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value ? 248 : 0}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Часов обучено"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.auth.value ? 1 : 0}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),

              Text(
                  "Курсов пройдено"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          )
        ],
      ),
    );
  }

  Widget getStatistikAuth() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              width: 1, color: Color(0xffECECEC)
          )
      ),
      height: 68,
      margin: EdgeInsets.only(top: _mainController.auth.value ? 27 : 57,
          left: 20,
          right: 20,
          bottom: 57),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.getStats['coursesStarted']}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Курса в процессе"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.getStats['lessonsHours']}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),
              Text(
                  "Часов обучено"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${_mainController.getStats['coursesEnded']}"
                  , style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black)),
              SizedBox(height: 2,),

              Text(
                  "Курсов пройдено"
                  , style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Color(0xff666666)))
            ],
          )
        ],
      ),
    );
  }

  Widget getGraph() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 57),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("Предпочтения категорий", style: black_text_title),
          ),
          SizedBox(height: 21,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: rightBarColor, size: 8,),
                  SizedBox(width: 6,),

                  Text("Прошли", style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 10,
                      fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(width: 32,),
              Row(
                children: [
                  Icon(Icons.circle, color: leftBarColor, size: 8),
                  SizedBox(width: 6,),
                  Text("В процесссе", style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 10,
                      fontWeight: FontWeight.w500),)
                ],
              )
            ],
          ),
          SizedBox(height: 21,),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
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
                              cornerStrategy: const charts.ConstCornerStrategy(
                                  50)),

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
                              tickProviderSpec: charts
                                  .BasicNumericTickProviderSpec(
                                desiredMinTickCount: 5,
                              ),
                              tickFormatterSpec: charts
                                  .BasicNumericTickFormatterSpec((num value) {
                                var index = value.floor();
                                return '$index курс';
                              })
                          ),
                          secondaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.NoneRenderSpec(),
                          ),
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

  Widget getGraphAuth() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 57),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text("Предпочтения категорий", style: black_text_title),
          ),
          SizedBox(height: 21,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: rightBarColor, size: 8,),
                  SizedBox(width: 6,),

                  Text("Прошли", style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 10,
                      fontWeight: FontWeight.w500))
                ],
              ),
              SizedBox(width: 32,),
              Row(
                children: [
                  Icon(Icons.circle, color: leftBarColor, size: 8),
                  SizedBox(width: 6,),
                  Text("В процесссе", style: TextStyle(fontFamily: 'Raleway',
                      fontSize: 10,
                      fontWeight: FontWeight.w500),)
                ],
              )
            ],
          ),
          SizedBox(height: 21,),
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
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
                              cornerStrategy: const charts.ConstCornerStrategy(
                                  50)),
                          primaryMeasureAxis: charts.NumericAxisSpec(
                              renderSpec: new charts.GridlineRendererSpec(
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 8, // size in Pts.
                                      color: charts.Color(
                                        r: 153,
                                        g: 153,
                                        b: 153,
                                      )),
                                  lineStyle: charts.LineStyleSpec(
                                    thickness: 1,
                                    color: charts.Color(
                                      r: 228,
                                      g: 228,
                                      b: 228,
                                    ),
                                  )),
                              tickProviderSpec: charts
                                  .BasicNumericTickProviderSpec(
                                desiredMinTickCount: 5,
                              ),
                              tickFormatterSpec: charts
                                  .BasicNumericTickFormatterSpec((num value) {
                                var index = value.floor();
                                return '$index курс';
                              })
                          ),
                          secondaryMeasureAxis: new charts.NumericAxisSpec(
                              renderSpec: new charts.GridlineRendererSpec(
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: 8, // size in Pts.
                                      color: charts.Color(
                                        r: 153,
                                        g: 153,
                                        b: 153,
                                      )),
                                  lineStyle: charts.LineStyleSpec(
                                    thickness: 1,
                                    color: charts.Color(
                                      r: 228,
                                      g: 228,
                                      b: 228,
                                    ),
                                  )),
                              tickProviderSpec: charts
                                  .BasicNumericTickProviderSpec(
                                desiredMinTickCount: 5,
                              ),
                              tickFormatterSpec: charts
                                  .BasicNumericTickFormatterSpec((num value) {
                                var index = value.floor();
                                return '';
                              })
                          ),
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

  List getMonth() {
    return [
      {'day': 31, 'name': 'январь', 'index': 1},
      {'day': 28, 'name': 'февраль', 'index': 2},
      {'day': 31, 'name': 'март', 'index': 3},
      {'day': 30, 'name': 'апрель', 'index': 4},
      {'day': 31, 'name': 'май', 'index': 5},
      {'day': 30, 'name': 'июнь', 'index': 6},
      {'day': 31, 'name': 'июль', 'index': 7},
      {'day': 31, 'name': 'август', 'index': 8},
      {'day': 30, 'name': 'сентябрь', 'index': 9},
      {'day': 31, 'name': 'октябрь', 'index': 10},
      {'day': 30, 'name': 'ноябрь', 'index': 11},
      {'day': 31, 'name': 'декабрь', 'index': 12}
    ];
  }

  Widget getActivities() {
    var list = [];
    var listStart = getMonth();
    listStart.removeRange(DateTime
        .now()
        .month, getMonth().length);
    list.addAll(getMonth().sublist(DateTime
        .now()
        .month, getMonth().length));
    list.addAll(listStart);
    list = list.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
          Text("Активность за последний год", style: black_text_title),
        ),
        Container(
          padding: EdgeInsets.only(top: 2, left: 20, right: 20, bottom: 30),

          child: Row(
            children: [
              Text("0 дней без перерыва   ", style: TextStyle(fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6A6A6A),
                  fontFamily: "Raleway"),),
              Container(
                width: 1, height: 23, color: Color(0xffc4c4c4),
              ),
              Text("   Всего 0 дней", style: TextStyle(fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6A6A6A),
                  fontFamily: "Raleway"))
            ],
          ),
        ),
        Container(
          height: 185,
          width: Get.width,
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.only(left: 13),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (c, i) {
              return Container(
                margin: EdgeInsets.only(right: 13),
                width: 76,
                height: 175,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: list[i]['day'],
                        itemBuilder: (c, index) {
                          return GestureDetector(
                            child: Container(
                              height: 16,
                              width: 16,
                              color: Color(0xfff2f2f2),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("${list[i]['name']} ", style: TextStyle(fontSize: 9,
                        color: Color(0xff6a6a6a),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        fontFamily: "Raleway"))
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 57,
        )
      ],
    );
  }

  Widget getActivitiesAuth() {
    var list = [];
    var listStart = getMonth();
    listStart.removeRange(DateTime
        .now()
        .month, getMonth().length);
    list.addAll(getMonth().sublist(DateTime
        .now()
        .month, getMonth().length));
    list.addAll(listStart);
    list = list.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
          Text("Активность за последний год", style: black_text_title),
        ),
        Container(
          padding: EdgeInsets.only(top: 2, left: 20, right: 20, bottom: 30),

          child: Row(
            children: [
              Text("${_mainController
                  .getStats['withoutSkipMax']} дней без перерыва   ",
                style: TextStyle(fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6A6A6A),
                    fontFamily: "Raleway"),),
              Container(
                width: 1, height: 23, color: Color(0xffc4c4c4),
              ),
              Text("   Всего ${_mainController.getStats['allDaysLearing']} дня",
                  style: TextStyle(fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6A6A6A),
                      fontFamily: "Raleway"))
            ],
          ),
        ),
        Container(
          height: 185,
          width: Get.width,
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.only(left: 13),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (c, i) {
              return Container(
                margin: EdgeInsets.only(right: 13),
                width: 76,
                height: 175,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: list[i]['day'],
                        itemBuilder: (c, index) {
                          Color color;
                          if (_mainController.getStats['lessons_stats']
                              .indexWhere((el) =>
                          DateTime
                              .parse(el['date'])
                              .day == index && list[i]['index'] - 1 == DateTime
                              .parse(el['date'])
                              .month - 1) >= 0) {
                            if (int.tryParse(_mainController
                                .getStats['lessons_stats'][_mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) > 0 ? _mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) : 0]['lessons_studied']) == 1) {
                              color = Color(0xffBBDEFF);
                            } else if (int.tryParse(_mainController
                                .getStats['lessons_stats'][_mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) > 0 ? _mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) : 0]['lessons_studied']) == 2) {
                              color = Color(0xff7ABFFF);
                            } else if (int.tryParse(_mainController
                                .getStats['lessons_stats'][_mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) > 0 ? _mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) : 0]['lessons_studied']) == 3) {
                              color = Color(0xff2597FF);
                            } else if (int.tryParse(_mainController
                                .getStats['lessons_stats'][_mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) > 0 ? _mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) : 0]['lessons_studied']) == 4) {
                              color = Color(0xff0075E0);
                            } else if (int.tryParse(_mainController
                                .getStats['lessons_stats'][_mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) > 0 ? _mainController
                                .getStats['lessons_stats'].indexWhere((el) =>
                            DateTime
                                .parse(el['date'])
                                .day == index &&
                                list[i]['index'] - 1 == DateTime
                                    .parse(el['date'])
                                    .month - 1) : 0]['lessons_studied']) >= 5) {
                              color = Color(0xff0054A1);
                            }
                          } else {
                            color = Color(0xfff2f2f2);
                          }
                          if (list[i]['index'] == DateTime
                              .now()
                              .month && index > DateTime
                              .now()
                              .day) {
                            color = Colors.white;
                          }
                          return GestureDetector(
                            child: Container(
                              height: 16,
                              width: 16,
                              color: color,
                            ),
                            onTap: () {
                              if (_mainController.getStats['lessons_stats']
                                  .indexWhere((el) =>
                              DateTime
                                  .parse(el['date'])
                                  .day == index &&
                                  list[i]['index'] - 1 == DateTime
                                      .parse(el['date'])
                                      .month - 1) >= 0) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  // user must tap button!
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 91,
                                        width: 252,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                10)
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end,
                                              children: [
                                                GestureDetector(
                                                  child: Icon(Icons.clear),
                                                  onTap: Get.back,
                                                )
                                              ],
                                            ),
                                            Text("${DateTime
                                                .parse(_mainController
                                                .getStats['lessons_stats'][_mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1) > 0
                                                ? _mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1)
                                                : 0]['date'])
                                                .day} "
                                                "${getMonth()[DateTime
                                                .parse(_mainController
                                                .getStats['lessons_stats'][_mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1) > 0
                                                ? _mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1)
                                                : 0]['date'])
                                                .month - 1]['name']} "
                                                "${DateTime
                                                .parse(_mainController
                                                .getStats['lessons_stats'][_mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1) > 0
                                                ? _mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1)
                                                : 0]['date'])
                                                .year} года", style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff0e0e0e),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                fontFamily: "Raleway")),
                                            Text("Уроков пройдено - "
                                                "${_mainController
                                                .getStats['lessons_stats'][_mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1) > 0
                                                ? _mainController
                                                .getStats['lessons_stats']
                                                .indexWhere((el) =>
                                            DateTime
                                                .parse(el['date'])
                                                .day == index &&
                                                list[i]['index'] - 1 == DateTime
                                                    .parse(el['date'])
                                                    .month - 1)
                                                : 0]['lessons_studied']}",
                                                style: TextStyle(fontSize: 12,
                                                    color: Color(0xff0e0e0e),
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.5,
                                                    fontFamily: "Raleway")),

                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                color = Color(0xfff2f2f2);
                              }
                            },
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("${list[i]['name']} ", style: TextStyle(fontSize: 9,
                        color: Color(0xff6a6a6a),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        fontFamily: "Raleway"))
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 57,
        )
      ],
    );
  }

  Widget getFinishedCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mainController.finishedCourses.length == 0
            ? Container() : Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
          Text("Завершенные курсы", style: black_text_title),
        ),
        _mainController.finishedCourses.length == 0
            ? Container() : Container(
          padding: EdgeInsets.only(left: 4, right: 4, top: 13),
          width: Get.width,
          height: 142,
          child: ListView.builder(
              padding: EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemCount: _mainController.allCourse
                  .where((element) =>
              _mainController.finishedCourses.indexWhere((
                  el) => element['id'] == el['course_id']) >= 0)
                  .toList()
                  .length,
              itemBuilder: (c, i) {
                return Item(
                    "${_mainController.allCourse.where((element) =>
                    _mainController.finishedCourses.indexWhere((
                        el) => element['id'] == el['course_id']) >= 0)
                        .toList()[i]['name']}",
                    "${_mainController.allCourse.where((element) =>
                    _mainController.finishedCourses.indexWhere((
                        el) => element['id'] == el['course_id']) >= 0)
                        .toList()[i]['banner_small']}",
                    _mainController.allCourse.where((element) =>
                    _mainController.finishedCourses.indexWhere((el) =>
                    element['id'] == el['course_id']) >= 0).toList()[i]['id'],
                    _homeController,
                    _mainController);
              }
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  void initStat() async {
    dios.Response getStats = await Backend().getStat(id: box.read('id'));
    _mainController.getStats.value = getStats.data['user_stats'][0];
    try {
      setState(() {

      });
    }catch(e){}
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class Item extends StatefulWidget {
  String text;
  String image;
  String id;
  var homeController;

  var mainController;

  Item(this.text, this.image, this.id, this.homeController,
      this.mainController);

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
      margin: EdgeInsets.only(right: 12),
      height: 142,
      width: 216,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black.withOpacity(0.04),
      ),) :
    GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 142,
        width: 216,
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
                width: 216,
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
      onTap: () async {
        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //     statusBarIconBrightness: Brightness.light,
        //     statusBarBrightness: Brightness.light,
        //     systemNavigationBarColor: Colors.white
        // ));
        Get.toNamed(Routes.COURSE, arguments: widget.id);
        widget.homeController.videos = {}.obs;
      },
    );
  }

}
