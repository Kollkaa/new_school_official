import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/controllers/auth_controller.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/settings.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Statehome();
  }
}

class Statehome extends State<HomePage> {
  HomeController _homeController = Get.put(HomeController());
  MainController _mainController = Get.find();
  AuthController _authController = Get.put(AuthController());
  final GetStorage box = GetStorage();

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  initPrefs() async {
    var responces = await Backend().getUser(id: box.read("id"));
    _mainController.profile.value = responces['clients'][0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var finished_course = _mainController.allCourse
        .where((element) =>
            _mainController.finishedCourses
                .indexWhere((el) => element['id'] == el['course_id']) <=
            0)
        .toList();

    List<Widget> contunies = [];
    _mainController.listContCourse.reversed.toList().map((el) {
      if (_mainController.getUservideo_time.reversed
                  .toList()
                  .where((element) => el['course_id'] == element['course_id'])
                  .length >
              1 &&
          finished_course
                  .where((element) => element['course_id'] == el['course_id'])
                  .length ==
              0) {
        if (_mainController.getUservideo_time.reversed.toList().indexWhere(
                (element) => el['course_id'] == element['course_id']) >=
            0) {
          if (el['lesson_id'] ==
                  _mainController.getUservideo_time.reversed.toList()[
                          _mainController.getUservideo_time.reversed
                              .toList()
                              .indexWhere((element) =>
                                  el['course_id'] == element['course_id'])]
                      ['lesson_id'] &&
              finished_course
                      .where((element) => element['id'] == el['course_id'])
                      .length ==
                  0) {
            contunies.add(ItemCont(
              el['lesson_id'],
              el['course_id'],
              el['time'],
              _homeController,
              _mainController,
            ));
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }
      if (finished_course
              .where((element) => element['id'] == el['course_id'])
              .length ==
          0) {
        print("Second");
        contunies.add(ItemCont(
          el['lesson_id'],
          el['course_id'],
          el['time'],
          _homeController,
          _mainController,
        ));
      } else {
        return Container();
      }
    });

    return GetBuilder(
        init: _homeController,
        builder: (value) => Scaffold(
              backgroundColor: white_color,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 27),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: _mainController
                                                                  .profile[
                                                              'avatar'] !=
                                                          null
                                                      ? NetworkImage(
                                                          "${_mainController.profile['avatar']}")
                                                      : AssetImage(
                                                          "assets/images/Group 242 (1).jpg",
                                                        ))),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        _mainController.auth.value
                                            ? Text(
                                                "${_mainController.profile['name'] != null ? _mainController.profile['name'] : "Имя"}",
                                                style: grey_text_title2,
                                              )
                                            : Text(
                                                "Вход",
                                                style: grey_text_title2,
                                              ),
                                      ],
                                    ),
                                    onTap: () {
                                      if (!_mainController.auth.value) {
                                        _mainController.widgets.removeAt(4);
                                        _mainController.widgets.add(AuthPage());
                                        _mainController.currentIndex.value = 4;
                                      } else {
                                        _mainController.currentIndex.value = 4;
                                      }
                                    },
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                            "assets/icons/settings.svg"),
                                        onTap: () async {
                                          if (!_mainController.auth.value) {
                                            _mainController.widgets.removeAt(4);
                                            _mainController.widgets
                                                .add(AuthPage());
                                            _mainController.currentIndex.value =
                                                4;
                                          } else {
                                            await Get.dialog(SettingPage());
                                            var responces = await Backend()
                                                .getUser(id: box.read("id"));
                                            _mainController.profile.value =
                                                responces.data['clients'][0];
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          //Продолжить
                          Obx(
                            () => _homeController.banner.value
                                ? Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _mainController.auth.value
                                            ? contunies.length != 0
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      "Продолжить",
                                                      style: black_text_title,
                                                    ),
                                                  )
                                                : Container()
                                            : Container(),
                                        _mainController.auth.value
                                            ? contunies.length != 0
                                                ? Container(
                                                    margin:
                                                        EdgeInsets.only(top: 7),
                                                    width: Get.width,
                                                    height: 223,
                                                    child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        addAutomaticKeepAlives:
                                                            true,
                                                        cacheExtent:
                                                            Get.width * 2,
                                                        itemCount:
                                                            contunies.length,
                                                        itemBuilder: (c, i) {
                                                          return contunies[i];
                                                        }),
                                                  )
                                                : Container()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    left: 15,
                                                    right: 15),
                                                width: Get.width - 30,
                                                height: 223,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        width: Get.width - 30,
                                                        height: 223,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                "assets/images/Group 248.png",
                                                              )),
                                                        )),
                                                    Positioned(
                                                        top: 11,
                                                        right: 13,
                                                        child: GestureDetector(
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/close-3 1 (1).svg",
                                                            height: 11,
                                                            width: 11,
                                                          ),
                                                          onTap: () {
                                                            _homeController
                                                                .banner
                                                                .value = false;
                                                          },
                                                        )),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Opacity(
                                                          child: Text(
                                                              'Учись новому!',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.5,
                                                                  fontFamily:
                                                                      "Raleway")),
                                                          opacity: 0.7,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 13,
                                                                  right: 13,
                                                                  top: 7),
                                                          width: Get.width,
                                                          child: AutoSizeText(
                                                              'Обучайтесь без ограничений'
                                                                  .toUpperCase(),
                                                              maxLines: 1,
                                                              minFontSize: 11,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "Raleway")),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 39,
                                                                  right: 39,
                                                                  top: 15),
                                                          child: Opacity(
                                                            child: FlatButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              highlightColor:
                                                                  Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.12),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(9),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Center(
                                                                  child: Text(
                                                                      'Начать учиться',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0.5,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              "Raleway")),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                _mainController
                                                                    .onIndexChanged(
                                                                        4);
                                                              },
                                                            ),
                                                            opacity: 0.7,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Opacity(
                                                          child: Text(
                                                              '30 дней бесплатно, далее 199 ₽ в месяц',
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "Raleway",
                                                                  letterSpacing:
                                                                      0.5)),
                                                          opacity: 0.7,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ),
                          //Популярное
                          Obx(() => Container(
                                padding: EdgeInsets.only(top: 34),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Популярное",
                                        style: black_text_title,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      width: Get.width,
                                      height: 142,
                                      child: _homeController.news.length == 0
                                          ? ListView.builder(
                                              itemCount: 4,
                                              itemBuilder: (i, c) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12),
                                                  height: 142,
                                                  width: 216,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.black
                                                        .withOpacity(0.04),
                                                  ),
                                                );
                                              },
                                            )
                                          : ListView.builder(
                                              cacheExtent: Get.width * 5,
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              scrollDirection: Axis.horizontal,
                                              addAutomaticKeepAlives: true,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: _homeController
                                                  .popular.length,
                                              itemBuilder: (c, i) {
                                                var el =
                                                    _homeController.popular[i];
                                                return Item(
                                                    "${el['name']}",
                                                    "${el['banner_small']}",
                                                    el['id'],
                                                    _homeController,
                                                    _mainController);
                                              },
                                            ),
                                    )
                                  ],
                                ),
                              )),
                          //Новое
                          Obx(() => Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Новое",
                                        style: black_text_title,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      width: Get.width,
                                      height: 142,
                                      child: _homeController.news.length == 0
                                          ? ListView.builder(
                                              itemCount: 4,
                                              itemBuilder: (i, c) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12),
                                                  height: 142,
                                                  width: 216,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.black
                                                        .withOpacity(0.04),
                                                  ),
                                                );
                                              },
                                            )
                                          : ListView(
                                              cacheExtent: Get.width * 5,
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              scrollDirection: Axis.horizontal,
                                              addAutomaticKeepAlives: true,
                                              physics: BouncingScrollPhysics(),
                                              children: [
                                                  ..._homeController.news
                                                      .map((el) => Item(
                                                          "${el['name']}",
                                                          "${el['banner_small']}",
                                                          el['id'],
                                                          _homeController,
                                                          _mainController))
                                                      .toList()
                                                ]),
                                    )
                                  ],
                                ),
                              )),
                          //Категории
                          Obx(() => Container(
                                padding: EdgeInsets.only(top: 30, bottom: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Категории",
                                        style: black_text_title,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      width: Get.width,
                                      height: 142,
                                      child: _homeController
                                                  .categorise.length ==
                                              0
                                          ? ListView.builder(
                                              itemCount: 4,
                                              itemBuilder: (i, c) {
                                                return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 12),
                                                    height: 142,
                                                    width: 142,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.black
                                                          .withOpacity(0.04),
                                                    ));
                                              },
                                            )
                                          : ListView.builder(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _homeController
                                                  .categorise.length,
                                              itemBuilder: (c, i) {
                                                return ItemCat(
                                                    "${_homeController.categorise[i]['name']}",
                                                    "${_homeController.categorise[i]['image']}",
                                                    "${_homeController.categorise[i]['id']}",
                                                    _homeController,
                                                    _mainController);
                                              }),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

class Item extends StatefulWidget {
  String text;
  String image;
  String id;
  var homeController;

  var mainController;
  Item(
      this.text, this.image, this.id, this.homeController, this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItem();
  }
}

class StateItem extends State<Item> {
  var _image;
  bool _loading = true;

  int lesAll = 0;

  int lesProg = 0;

  @override
  void initState() {
    StreamController<int> controller = StreamController<int>();
    Stream stream = controller.stream;
    stream.listen((value) async {
      initImage();
      var stat = await Backend().getStatCourse(widget.id);
      lesAll = int.tryParse(stat.data[0]['lessons_count']);
      lesProg = widget.mainController.getUservideo_time
          .where((el) => el['course_id'] == widget.id)
          .length;
      print(
          "${widget.mainController.getUservideo_time_all.length} $lesAll/$lesProg");
    });
    controller.add(1);
  }

  initImage() {
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
    print(
        "${widget.mainController.getUservideo_time_all.length} $lesAll/$lesProg");
    return _loading
        ? Container(
            margin: EdgeInsets.only(right: 12),
            height: 142,
            width: 216,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.04),
            ),
          )
        : GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 12),
              height: 142,
              width: 216,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.04),
                  image: DecorationImage(image: _image, fit: BoxFit.cover)),
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
                              ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 18, right: 10, bottom: 12),
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
                  widget.mainController.finishedCourses
                              .where((element) =>
                                  element['course_id'] == widget.id)
                              .length ==
                          0
                      ? !((Get.width * (lesProg / lesAll)) > Get.width
                                  ? Get.width - 50
                                  : (Get.width * (lesProg / lesAll) - 35))
                              .isNaN
                          ? ((Get.width * (lesProg / lesAll)) > Get.width
                                      ? Get.width - 50
                                      : (Get.width * (lesProg / lesAll) -
                                          35)) >=
                                  0
                              ///////////////////////////////////////////////////////////////////
                              ? widget.mainController.auth.value
                                  ? Positioned(
                                      bottom: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 7, right: 100),
                                        height: 2,
                                        width: (Get.width *
                                                    (lesProg / lesAll)) >
                                                Get.width
                                            ? Get.width - 50
                                            : (Get.width * (lesProg / lesAll) -
                                                35),
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container()
                              : Container()
                          : Container()
                      : Container()
                ],
              ),
            ),
            onTap: () async {
              // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              //     statusBarIconBrightness: Brightness.light,
              //     statusBarBrightness: Brightness.light,
              //     systemNavigationBarColor: Colors.white
              // ));
              widget.homeController.videos = {}.obs;
              Get.appUpdate();
              Get.toNamed(Routes.COURSE, arguments: widget.id);
            },
          );
  }
}

class ItemCat extends StatefulWidget {
  String text;
  String image;
  String id;
  HomeController homeController;

  var mainController;

  ItemCat(
      this.text, this.image, this.id, this.homeController, this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItemCat();
  }
}

class StateItemCat extends State<ItemCat> {
  var _image;
  bool _loading = true;
  initImage() {
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
  void initState() {
    StreamController<int> controller = StreamController<int>();
    Stream stream = controller.stream;
    stream.listen((value) async {
      initImage();
    });
    ;
    controller.add(1);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            margin: EdgeInsets.only(right: 12),
            height: 142,
            width: 142,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.04),
            ),
          )
        : GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 12),
              height: 142,
              width: 142,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.04),
                  image: DecorationImage(image: _image, fit: BoxFit.fill)),
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
                              colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0)
                              ])),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AutoSizeText(
                        widget.text,
                        style: TextStyle(
                            color: white_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            fontFamily: "Raleway"),
                        minFontSize: 10,
                        maxLines: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () async {
              await widget.homeController
                  .getCoursesByCat(widget.id, widget.text);
            },
          );
  }
}

class ItemCont extends StatefulWidget {
  String idVideo;
  String idCourse;
  var duration;
  var homeController;
  var mainController;

  ItemCont(this.idVideo, this.idCourse, this.duration, this.homeController,
      this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItemCont();
  }
}

class StateItemCont extends State<ItemCont> {
  bool _loading = true;
  var image;
  var _image;
  var video;
  var course;
  @override
  void initState() {
    getVideo();
  }

  var lesAll = 0;
  var lesProg = 0;
  void getVideo() async {
    StreamController<int> controller = StreamController<int>();
    Stream stream = controller.stream;
    stream.listen((value) async {
      var responce = await Backend().getCourse(widget.idCourse);
      print("kurses ${responce.data}");
      course = responce.data.length != 0 ? responce.data['kurses'][0] : null;
      image = course != null ? course['banner_small'] : null;
      StreamController<int> controller = StreamController<int>();
      Stream stream = controller.stream;
      stream.listen((value) async {
        initImage();
      });
      ;
      course != null ? controller.add(1) : null;
      var stat = await Backend().getStatCourse(widget.idCourse);
      lesAll = int.tryParse(stat.data[0]['lessons_count']);
      lesProg = widget.mainController.getUservideo_time
          .where((el) => el['course_id'] == widget.idCourse)
          .length;
      setState(() {});
    });
    controller.add(1);
  }

  initImage() {
    _image = new NetworkImage(
      '${image}',
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
    print((lesAll / lesProg));
    print(Get.width * (lesProg / lesAll));

    return image != null &&
            !((Get.width * (lesProg / lesAll)) > Get.width
                    ? Get.width - 50
                    : (Get.width * (lesProg / lesAll) - 35))
                .isNaN
        ? _loading
            ? Container(
                margin: EdgeInsets.only(right: 12),
                height: 142,
                width: 142,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.04),
                ),
              )
            : GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  height: 223,
                  width: 339,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black.withOpacity(0.04),
                      image: DecorationImage(image: _image, fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: 339,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(1),
                                    Colors.black.withOpacity(0)
                                  ])),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 25, right: 10, bottom: 12),
                          child: AutoSizeText(
                            course['topic'],
                            style: white_title3_card_text_title,
                            minFontSize: 10,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 7, right: 100),
                          height: 2,
                          width: (Get.width * (lesProg / lesAll)) > Get.width
                              ? Get.width - 50
                              : (Get.width * (lesProg / lesAll) - 35),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  Get.toNamed(Routes.COURSE, arguments: widget.idCourse);

                  setState(() {});
                },
              )
        : Container();
  }
}

class ItemConte extends StatefulWidget {
  String idVideo;
  String idCourse;
  var duration;
  var homeController;
  var mainController;

  ItemConte(this.idVideo, this.idCourse, this.duration, this.homeController,
      this.mainController);

  @override
  State<StatefulWidget> createState() {
    return StateItemConte();
  }
}

class StateItemConte extends State<ItemCont> {
  bool _loading = true;
  var image;
  var _image;
  var video;
  var course;
  @override
  void initState() {
    getVideo();
  }

  var lesAll = 0;
  var lesProg = 0;
  void getVideo() async {
    StreamController<int> controller = StreamController<int>();
    Stream stream = controller.stream;
    stream.listen((value) async {
      var responce = await Backend().getCourse(widget.idCourse);
      course = responce.data.length != 0 ? responce.data['kurses'][0] : null;
      image = course != null ? course['banner_small'] : null;
      StreamController<int> controller = StreamController<int>();
      Stream stream = controller.stream;
      stream.listen((value) async {
        initImage();
      });
      ;
      course != null ? controller.add(1) : null;
      var stat = await Backend().getStatCourse(widget.idCourse);
      lesAll = int.tryParse(stat.data[0]['lessons_count']);
      lesProg = widget.mainController.getUservideo_time
          .where((el) => el['course_id'] == widget.idCourse)
          .length;
      setState(() {});
    });
    controller.add(1);
  }

  initImage() {
    _image = new NetworkImage(
      '${image}',
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
    return image != null &&
            !((Get.width * (lesProg / lesAll)) > Get.width
                    ? Get.width - 50
                    : (Get.width * (lesProg / lesAll) - 35))
                .isNaN
        ? _loading
            ? Container(
                margin: EdgeInsets.only(right: 20),
                height: 142,
                width: 216,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black.withOpacity(0.04),
                ),
              )
            : GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  height: 142,
                  width: 216,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black.withOpacity(0.04),
                      image: DecorationImage(image: _image, fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: 216,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(1),
                                    Colors.black.withOpacity(0)
                                  ])),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 25, right: 10, bottom: 12),
                          child: AutoSizeText(
                            course['topic'],
                            style: white_title3_card_text_title,
                            minFontSize: 10,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 7, right: 100),
                          height: 2,
                          width: (Get.width * (lesProg / lesAll)) > Get.width
                              ? Get.width - 50
                              : (Get.width * (lesProg / lesAll) - 35),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  Get.toNamed(Routes.COURSE, arguments: widget.idCourse);

                  setState(() {});
                },
              )
        : Container();
  }
}
