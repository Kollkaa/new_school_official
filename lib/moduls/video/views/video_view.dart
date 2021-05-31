import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/custom/controlls.dart';
import 'package:new_school_official/moduls/course/controllers/course_controller.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoScreen extends StatefulWidget {
  var lesson;
  var duration;
  var index;

  VideoScreen(this.lesson, {this.index, this.duration});

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<VideoScreen> {
  HomeController _homeController = Get.find();
  MainController _mainController = Get.find();
  CourseController _courseController = Get.find();
  ChewieController _chewieController;
  bool method1 = false;
  final GetStorage box = GetStorage();
  var oldPos = 0;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    oldPos = widget.duration != null ? widget.duration : 0;
  }

  updateVideoStat() async {
    if (_mainController.auth.value) {
      await Backend().setPos(
          _homeController.videos['lessons'].reversed.toList()[(widget.index)]
              ['kurs_id'],
          _homeController.videos['lessons'].reversed.toList()[(widget.index)]
              ['id'],
          _chewieController.videoPlayerController.value.position.inSeconds,
          _chewieController.videoPlayerController.value.duration.inSeconds);
      if (box.read('id') != null) {
        _mainController.initProfile(box.read("id"));
        _courseController.initCheckedVideos();
        Get.appUpdate();
      }
    }
  }

  @override
  void dispose() {
    try {
      if (_mainController.auth.value &&
          _mainController.profile['subscriber'] != '0') if (_chewieController
              .videoPlayerController.value.position.inSeconds ==
          _chewieController.videoPlayerController.value.duration.inSeconds) {
        updateVideoStat();
      }
    } catch (e) {}
    try {
      myOverayEntry.remove();
    } catch (e) {}
    if (_chewieController.videoPlayerController != null) {
      try {
        _chewieController.videoPlayerController.removeListener(() {});
        _chewieController.videoPlayerController.dispose();
      } catch (e) {}
    }
    if (_chewieController != null) {
      try {
        _chewieController.removeListener(() {});
        _chewieController.dispose();
      } catch (e) {}
    }
    loadProfile();

    super.dispose();
  }

  loadProfile() async {
    if (_mainController.profile['id'] != null) {
      await _mainController.initProfile(_mainController.profile['id']);
    }
  }

  VideoPlayerController videoPlayerController =
      new VideoPlayerController.network("dataSource");

  Future<void> initializePlayer() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() {});
    if (Get.height > 1920) {
      if (widget.lesson['videos'].indexWhere((el) => el['quality'] == "720") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "720")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "480") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "480")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "1080") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "1080")]['video_url']);
      }
    } else if (Get.height >= 2560) {
      if (widget.lesson['videos'].indexWhere((el) => el['quality'] == "1080") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "1080")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "720") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "720")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "480") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "480")]['video_url']);
      }
    } else if (Get.height >= 4096) {
      if (widget.lesson['videos'].indexWhere((el) => el['quality'] == "1080") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "1080")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "720") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "720")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "480") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "480")]['video_url']);
      }
    } else {
      if (widget.lesson['videos'].indexWhere((el) => el['quality'] == "480") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "480")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "720") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "720")]['video_url']);
      } else if (widget.lesson['videos']
              .indexWhere((el) => el['quality'] == "1080") >=
          0) {
        videoPlayerController = new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos']
                .indexWhere((el) => el['quality'] == "1080")]['video_url']);
      }
    }
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      startAt: Duration(seconds: widget.duration != null ? widget.duration : 0),
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      showControlsOnInitialize: false,
      showControls: false,
      allowFullScreen: false,
      fullScreenByDefault: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.purple,
        handleColor: Colors.purple,
        backgroundColor: Colors.black,
        bufferedColor: Colors.purple[100],
      ),
      placeholder: Container(
        color: Colors.black,
      ),
    );
    _chewieController.videoPlayerController.addListener(() {
      if (_mainController.auth.value &&
          _mainController.profile['subscriber'] != '0') if (_chewieController
              .videoPlayerController.value.position.inSeconds ==
          _chewieController.videoPlayerController.value.duration.inSeconds) {
        if ((widget.index + 1) <=
            _homeController.videos['lessons'].length - 1) {
          Get.back();
          Get.to(VideoScreen(
              _homeController.videos['lessons'].reversed
                  .toList()[(widget.index + 1)],
              index: widget.index + 1));
          _mainController.initProfile(box.read("id"));
        } else {
          SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.bottom, SystemUiOverlay.top]);
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white));
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          // SystemChrome.setPreferredOrientations([
          //   DeviceOrientation.landscapeRight,
          //   DeviceOrientation.landscapeLeft,
          //   DeviceOrientation.portraitUp,
          //   DeviceOrientation.portraitDown,
          // ]);
          // setState(() {});
          Get.back();
          Get.toNamed(Routes.TEST);
        }
        method1 = true;
      }
    });
    myOverayEntry = getMyOverlayEntry(context: context);
    Overlay.of(context).insert(myOverayEntry);
    setState(() {});
  }

  OverlayEntry myOverayEntry;

  OverlayEntry getMyOverlayEntry({
    @required BuildContext context,
  }) {
    return new OverlayEntry(
        builder: (context) => Positioned(
              child: CupertinoControls(
                chewieController: _chewieController,
                backgroundColor: Color(0xff232323),
                image: _mainController.auth.value &&
                        _mainController.profile['subscriber'] != '0'
                    ? ((_homeController.videos['lessons'].length - 1) >=
                            (widget.index + 1))
                        ? _homeController.videos['lessons'].reversed
                            .toList()[widget.index + 1]['video_image']
                        : null
                    : null,
                iconColor: Colors.white,
                id: _homeController.videos['lessons'].reversed
                    .toList()[(widget.index)]['id'],
                kurs_id: _homeController.videos['lessons'].reversed
                    .toList()[(widget.index)]['kurs_id'],
                method: () {
                  if (!method1) {
                    try {
                      print("NEXT");
                      updateVideoStat();
                    } catch (e) {}
                    // ignore: unnecessary_statements
                    myOverayEntry != null ? myOverayEntry.remove() : null;
                    if ((widget.index + 1) <=
                        _homeController.videos['lessons'].length - 1) {
                      if (_mainController.auth.value &&
                          _mainController.profile['subscriber'] != '0') {
                        Get.back();
                        Get.to(VideoScreen(
                            _homeController.videos['lessons'].reversed
                                .toList()[(widget.index + 1)],
                            index: widget.index + 1));
                        // ignore: close_sinks
                        // StreamController<int> controller =
                        //     StreamController<int>();
                        // Stream stream = controller.stream;
                        // stream.listen((value) async {
                        _mainController.initProfile(box.read("id"));
                        //   setState(() {});
                        // });
                        // controller.add(1);
                      } else {
                        SystemChrome.setEnabledSystemUIOverlays(
                            [SystemUiOverlay.bottom, SystemUiOverlay.top]);
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                                statusBarColor: Colors.white,
                                statusBarIconBrightness: Brightness.dark,
                                statusBarBrightness: Brightness.dark,
                                systemNavigationBarColor: Colors.white));
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);
                        // SystemChrome.setPreferredOrientations([
                        //   DeviceOrientation.landscapeRight,
                        //   DeviceOrientation.landscapeLeft,
                        //   DeviceOrientation.portraitUp,
                        //   DeviceOrientation.portraitDown,
                        // ]);
                        // setState(() {});
                        // Get.toNamed(Routes.TEST);
                        Get.back();
                      }
                    } else {
                      SystemChrome.setEnabledSystemUIOverlays(
                          [SystemUiOverlay.bottom, SystemUiOverlay.top]);
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                          systemNavigationBarIconBrightness: Brightness.dark,
                          systemNavigationBarColor: Colors.white));
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      // SystemChrome.setPreferredOrientations([
                      //   DeviceOrientation.landscapeRight,
                      //   DeviceOrientation.landscapeLeft,
                      //   DeviceOrientation.portraitUp,
                      //   DeviceOrientation.portraitDown,
                      // ]);
                      // setState(() {});

                    }
                  }
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    try {
      return WillPopScope(
          child: Material(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                color: Colors.black,
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: _chewieController != null &&
                          _chewieController
                              .videoPlayerController.value.initialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                ),
              ),
            ),
          ),
          onWillPop: () {
            // Get.back();
            SystemChrome.setEnabledSystemUIOverlays(
                [SystemUiOverlay.bottom, SystemUiOverlay.top]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white));
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            // SystemChrome.setPreferredOrientations([
            //   DeviceOrientation.landscapeRight,
            //   DeviceOrientation.landscapeLeft,
            //   DeviceOrientation.portraitUp,
            //   DeviceOrientation.portraitDown,
            // ]);
            // ignore: close_sinks
            // StreamController<int> controller = StreamController<int>();
            // Stream stream = controller.stream;
            // stream.listen((value) async {
            //   updateVideoStat();
            // });
            // controller.add(oldPos);
            // setState(() {});
            return Future<bool>(() => true);
          });
    } catch (e) {
      return Container();
    }
  }

  // ignore: non_constant_identifier_names
  showOverlay(BuildContext context, Controller) async {}
}
