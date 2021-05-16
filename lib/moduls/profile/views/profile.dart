import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart' as dios;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/controllers/profile_controller.dart';
import 'package:new_school_official/moduls/profile/views/settings.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateProfile();
  }
}

class StateProfile extends State<ProfilePage> {
  ProfileController _profileController = Get.put(ProfileController());
  HomeController _homeController = Get.find();
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();
  bool loadedImage = false;

  Image _image;
  @override
  void initState() {
    super.initState();
    initStat();
    loadImage();
  }

  void loadImage() {
    if (_mainController.profile['avatar'] != null) {
      _image = Image.network(
        "${_mainController.profile['avatar']}",
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      );
      _image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
          (info, call) {
            setState(() {
              loadedImage = true;
            });
            // do something
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(box.read("id"));

    return Scaffold(
      backgroundColor: white_color,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 27),
                            child: Text(
                              "Профиль",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontFamily: 'Raleway'),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 27, right: 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                        "assets/icons/settings.svg"),
                                    onTap: () async {
                                      if (!_mainController.auth.value) {
                                        _mainController.widgets.removeAt(4);
                                        _mainController.widgets.add(AuthPage());
                                        _mainController.currentIndex.value = 4;
                                      } else {
                                        await Get.to(SettingPage(),
                                            duration: Duration());
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
                              ))
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 66),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: ClipOval(
                            child: loadedImage
                                ? _image
                                : SvgPicture.asset(
                                    "assets/icons/Group 242.svg",
                                    height: 120,
                                    width: 120,
                                  ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "${_mainController.profile['name'] != null ? _mainController.profile['name'] : "Имя"} ${_mainController.profile['lastname'] != null ? _mainController.profile['lastname'] : "Фамилия"}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontFamily: 'Raleway'),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Container(
                              child: Text(
                                "${_mainController.profile['email']}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff6a6a6a),
                                    fontFamily: 'Raleway'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  getStatistikAuth(),
                  // getType("Мой список",_homeController.news.length,
                  //     getitemOtherCard,_homeController.news
                  // ),
                  _mainController.listContCourse.length != 0
                      ? Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Продолжить просмотр",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        )
                      : Container(),
                  _mainController.listContCourse.length != 0
                      ? Container(
                          margin: EdgeInsets.only(top: 7),
                          width: Get.width,
                          height: 152,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              addAutomaticKeepAlives: true,
                              cacheExtent: Get.width * 2,
                              itemCount:
                                  _mainController.getUservideo_time.length,
                              itemBuilder: (c, i) {
                                if (_mainController.getUservideo_time.reversed
                                            .toList()
                                            .where((element) =>
                                                _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()[i]['course_id'] ==
                                                element['course_id'])
                                            .length >
                                        1 &&
                                    _mainController.finishedCourses
                                            .where((element) {
                                          return element['course_id'] ==
                                              _mainController
                                                  .getUservideo_time.reversed
                                                  .toList()[i]['course_id'];
                                        }).length ==
                                        0) {
                                  if (_mainController.getUservideo_time.reversed
                                          .toList()
                                          .indexWhere((element) =>
                                              _mainController
                                                  .getUservideo_time.reversed
                                                  .toList()[i]['course_id'] ==
                                              element['course_id']) >=
                                      0) {
                                    if (_mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['lesson_id'] ==
                                        _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()[
                                                _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()
                                                    .indexWhere((element) =>
                                                        _mainController
                                                                .getUservideo_time
                                                                .reversed
                                                                .toList()[i]
                                                            ['course_id'] ==
                                                        element['course_id'])]
                                            ['lesson_id']) {
                                      return ItemCont(
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['lesson_id'],
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['course_id'],
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['time'],
                                        _homeController,
                                        _mainController,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                }
                                if (_mainController.finishedCourses
                                        .where((element) =>
                                            element['course_id'] ==
                                            _mainController
                                                .getUservideo_time.reversed
                                                .toList()[i]['course_id'])
                                        .length ==
                                    0) {
                                  return ItemCont(
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['lesson_id'],
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['course_id'],
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['time'],
                                    _homeController,
                                    _mainController,
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        )
                      : Container(),
                  _mainController.listContCourse.length != 0
                      ? SizedBox(
                          height: 45,
                        )
                      : Container(),

                  _mainController.listContCourse.length != 0
                      ? Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Не пройденные тесты",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        )
                      : Container(),
                  _mainController.getUservideo_time.length != 0
                      ? Container(
                          margin: EdgeInsets.only(top: 7),
                          width: Get.width,
                          height: 152,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              addAutomaticKeepAlives: true,
                              cacheExtent: Get.width * 2,
                              itemCount:
                                  _mainController.getUservideo_time.length,
                              itemBuilder: (c, i) {
                                if (_mainController.getUservideo_time.reversed
                                            .toList()
                                            .where((element) =>
                                                _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()[i]['course_id'] ==
                                                element['course_id'])
                                            .length >
                                        1 &&
                                    _mainController.finishedCourses
                                            .where((element) {
                                          return element['course_id'] ==
                                              _mainController
                                                  .getUservideo_time.reversed
                                                  .toList()[i]['course_id'];
                                        }).length ==
                                        0) {
                                  if (_mainController.getUservideo_time.reversed
                                          .toList()
                                          .indexWhere((element) =>
                                              _mainController
                                                  .getUservideo_time.reversed
                                                  .toList()[i]['course_id'] ==
                                              element['course_id']) >=
                                      0) {
                                    if (_mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['lesson_id'] ==
                                        _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()[
                                                _mainController
                                                    .getUservideo_time.reversed
                                                    .toList()
                                                    .indexWhere((element) =>
                                                        _mainController
                                                                .getUservideo_time
                                                                .reversed
                                                                .toList()[i]
                                                            ['course_id'] ==
                                                        element['course_id'])]
                                            ['lesson_id']) {
                                      return ItemCont(
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['lesson_id'],
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['course_id'],
                                        _mainController
                                            .getUservideo_time.reversed
                                            .toList()[i]['time'],
                                        _homeController,
                                        _mainController,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                }
                                if (_mainController.finishedCourses
                                        .where((element) =>
                                            element['course_id'] ==
                                            _mainController
                                                .getUservideo_time.reversed
                                                .toList()[i]['course_id'])
                                        .length ==
                                    0) {
                                  return ItemCont(
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['lesson_id'],
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['course_id'],
                                    _mainController.getUservideo_time.reversed
                                        .toList()[i]['time'],
                                    _homeController,
                                    _mainController,
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        )
                      : Container(),
                  _mainController.getUservideo_time.length != 0
                      ? SizedBox(
                          height: 45,
                        )
                      : Container(),

                  _mainController.finishedCourses.length == 0
                      ? Container()
                      : getType(
                          "Завершенные курсы",
                          _mainController.allCourse
                              .where((element) =>
                                  _mainController.finishedCourses
                                      .where((el) =>
                                          element['id'] == el['course_id'])
                                      .length >=
                                  1)
                              .length,
                          getitemOtherCard,
                          _mainController.allCourse
                              .where((element) =>
                                  _mainController.finishedCourses
                                      .where((el) =>
                                          element['id'] == el['course_id'])
                                      .length >=
                                  1)
                              .toList()),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getStatistikAuth() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: Color(0xffECECEC))),
      height: 68,
      margin: EdgeInsets.only(
          top: _mainController.auth.value ? 27 : 57,
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
              Text("${_mainController.getStats['coursesStarted']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Colors.black)),
              SizedBox(
                height: 2,
              ),
              Text("Курса в процессе",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${_mainController.getStats['lessonsHours']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Colors.black)),
              SizedBox(
                height: 2,
              ),
              Text("Часов обучено",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Color(0xff666666)))
            ],
          ),
          // SizedBox(width:50,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${_mainController.getStats['coursesEnded']}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Colors.black)),
              SizedBox(
                height: 2,
              ),
              Text("Курсов пройдено",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Color(0xff666666)))
            ],
          )
        ],
      ),
    );
  }

  Widget getType(text, length, item, type) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "${text}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: Get.width,
            height: 142,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: length,
                itemBuilder: (c, i) {
                  return item("${type[i]['name']}",
                      "${type[i]['banner_small']}", type[i]['id']);
                }),
          )
        ],
      ),
    );
  }

  Widget getitemOtherCard(text, image, id) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 12),
        height: 142,
        width: 216,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue,
            image: DecorationImage(
                image: NetworkImage("${image}"), fit: BoxFit.cover)),
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
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 10, bottom: 12),
                child: AutoSizeText(
                  text,
                  style: white_title2_card_text_title,
                  minFontSize: 10,
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () async {
        Get.toNamed(Routes.COURSE, arguments: id);
      },
    );
  }

  void initStat() async {
    dios.Response getStats = await Backend().getStat(id: box.read('id'));
    _mainController.getStats.value = getStats.data['user_stats'][0];
    setState(() {});
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
