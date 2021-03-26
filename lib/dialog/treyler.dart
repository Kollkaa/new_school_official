import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
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
  HomeController _homeController=Get.find();

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black
    ));
    setState(() {

    });
    print( _homeController.course['kurses'][0]['trailer']);
    _videoPlayerController1 = VideoPlayerController.network(
        _homeController.course['kurses'][0]['trailer']);
    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      allowFullScreen: false,
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      showControls: true,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.iOS,
      ),
      home:  Material(
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
                  child: _chewieController != null &&
                      _chewieController
                          .videoPlayerController.value.initialized
                      ?  Chewie(

                    controller: _chewieController,
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),

            ],
          )
        ),
      ),
    );
  }



}