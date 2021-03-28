import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
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
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black
    ));
    setState(() {

    });
    print(_homeController.course['kurses'][0]['trailer']);

    _videoPlayerController1 = VideoPlayerController.network(
        _homeController.course['kurses'][0]['trailer']);
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16/9,
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.iOS,
      ),
      home: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onHorizontalDragStart: (DragStartDetails details) {
          print(123);
          showOverlay(context, _chewieController) ;
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          print(123);

          showOverlay(context, _chewieController) ;
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          print(123);

          showOverlay(context, _chewieController);
        },
        onTapDown: (TapDownDetails details) {
          print(123);
           showOverlay(context, _chewieController) ;
        },
        child: Material(
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      // child:  BetterPlayer(
                      //   controller: _betterPlayerController,
                      // ),
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
              )
          ),
        ),
      ),
    );
  }

  showOverlay(BuildContext context,Controller) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(child: CupertinoControls(chewieController: Controller,backgroundColor: Color(0xff232323),iconColor: Colors.white,),));

// OverlayEntry overlayEntry = OverlayEntry(
//         builder: (context) => Positioned(
//               top: MediaQuery.of(context).size.height / 2.0,
//               width: MediaQuery.of(context).size.width / 2.0,
//               child: CircleAvatar(
//                 radius: 50.0,
//                 backgroundColor: Colors.red,
//                 child: Text("1"),
//               ),
//             ));
    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 4));

    overlayEntry.remove();
  }
}