import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_school_official/custom/controlls.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

class TrailerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<TrailerScreen> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  HomeController _homeController = Get.find();

  bool cansel = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    myOverayEntry.remove();
    _chewieController.videoPlayerController.removeListener(() {});
    _chewieController.removeListener(() {});
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black26,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black26));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(() {});

    _videoPlayerController1 = VideoPlayerController.network(
        _homeController.course['kurses'][0]['trailer']);
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
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
    myOverayEntry = getMyOverlayEntry(context: context);
    Overlay.of(context).insert(myOverayEntry);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (d) {
                print("Ontap");
                myOverayEntry = getMyOverlayEntry(context: context);
                Overlay.of(context).insert(myOverayEntry);
              },
              onTapCancel: () {
                showOverlay(context, _chewieController);
              },
              child: Stack(
                children: [
                  Container(
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
                ],
              ))),
    );
  }

  OverlayEntry myOverayEntry;
  OverlayEntry getMyOverlayEntry({
    @required BuildContext context,
  }) {
    return new OverlayEntry(
        builder: (context) => _chewieController != null
            ? _chewieController.videoPlayerController != null
                ? Positioned(
                    child: CupertinoControls(
                      chewieController: _chewieController,
                      backgroundColor: Color(0xff232323),
                      image: null,
                      iconColor: Colors.white,
                      id: null,
                      kurs_id: null,
                      method: () {
                        myOverayEntry != null ? myOverayEntry.remove() : null;

                        Get.back();
                      },
                    ),
                  )
                : Container()
            : Container());
  }

  showOverlay(BuildContext context, Controller) async {}
}
