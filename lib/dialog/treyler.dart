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
  VideoPlayerController _videoPlayerController2;
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
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    print(_homeController.course['kurses'][0]['trailer']);
    _videoPlayerController1 = VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4');
    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      showControls: true,
      systemOverlaysOnEnterFullScreen: [SystemUiOverlay.bottom]
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
              SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
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
                          children: const [
                            CircularProgressIndicator(),

                          ],
                        ),
                      ),
                    ),
                  )
              ),
              _chewieController != null &&
                  _chewieController
                      .videoPlayerController.value.initialized
                  ?  Positioned(
                bottom: 50,
                right: 30,
                child: ValueListenableBuilder(
                  valueListenable: _chewieController
                      .videoPlayerController,
                  builder: (context, VideoPlayerValue value, child) {
                    print(value.position.inSeconds);
                    if(value.position.inSeconds>=(_chewieController.videoPlayerController.value.duration.inSeconds-15)){
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black.withOpacity(0.04),
                                  image: DecorationImage(image: NetworkImage(
                                      "https://school.webfirst.rv.ua/admin/uploads/category/9810_5957_1615109386.jpg"
                                  ),fit: BoxFit.fill)
                              ),),
                            Text("Следующее видео",style: TextStyle(color: Colors.white),),

                          ],
                        ),
                      );
                    }else{
                      return Container(

                      );
                    }
                  },
                ),
              ):Container()
            ],
          )
        ),
      ),
    );
  }



}