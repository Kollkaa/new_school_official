import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_school_official/custom/controlls.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  var lesson;
  var duration;
  var index;
  VideoScreen(this.lesson,{this.index, this.duration});

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}
class _ChewieDemoState extends State<VideoScreen> {

  HomeController _homeController=Get.find();
  BetterPlayerController _betterPlayerController;

  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();


  }
  VideoPlayerController videoPlayerController;
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
    print(widget.lesson['videos'][0]['video_url']);
    videoPlayerController = VideoPlayerController.network(
        widget.lesson['videos'][0]['video_url'],
        );

    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      startAt: Duration(seconds: widget.duration!=null?int.tryParse(widget.duration):0),
      videoPlayerController: videoPlayerController,
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
        // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.NETWORK,
    //     widget.lesson['videos'][0]['video_url']);
    // _betterPlayerController = BetterPlayerController(
    //
    //     BetterPlayerConfiguration(
    //       autoPlay: true,
    //       looping: true,
    //       controlsConfiguration: BetterPlayerControlsConfiguration(
    //         enableFullscreen: false,
    //       )
    //     ),
    //     betterPlayerDataSource: betterPlayerDataSource);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.lesson['videos'][0]['video_url']);
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.iOS,
      ),
      home: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            _chewieController != null &&
                _chewieController
                    .videoPlayerController.value.initialized
                ?showOverlay(context,_chewieController):null;
          },
          onTapDown: (_) {
            _chewieController != null &&
                _chewieController
                    .videoPlayerController.value.initialized
                ? showOverlay(context,_chewieController):null;
          },
        onTapUp: (_){
          _chewieController != null &&
              _chewieController
                  .videoPlayerController.value.initialized
              ? showOverlay(context,_chewieController):null;
        },
        onTapCancel: (){
          _chewieController != null &&
              _chewieController
                  .videoPlayerController.value.initialized
              ? showOverlay(context,_chewieController):null;
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

                    Positioned(
                      bottom: 50,
                      right: 30,
                      child: ValueListenableBuilder(
                        valueListenable: _chewieController.videoPlayerController,
                        builder: (context, var value, child) {
                          if(value.position.inSeconds==(_chewieController.videoPlayerController.value.duration.inSeconds))
                          {
                            Get.back();
                            if((widget.index+1)<=_homeController.videos['lessons'].length-1){
                              Get.dialog(VideoScreen(_homeController.videos['lessons'].reversed.toList()[(widget.index+1)],index:widget.index+1));
                            }else{
                            }
                          }
                          print(value.position.inSeconds);
                          if(value.position.inSeconds>=(_chewieController.videoPlayerController.value.duration.inSeconds-15)){
                            if((widget.index+1)<_homeController.videos['lessons'].length-1){
                              return  GestureDetector(
                                child: Container(
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
                                                _homeController.videos['lessons'].reversed.toList()[widget.index+1]['video_image']
                                            ),fit: BoxFit.fill)
                                        ),),
                                      Text("Следующее видео",style: TextStyle(color: Colors.white),),

                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Get.back();
                                  if((widget.index+1)<=_homeController.videos['lessons'].length-1){
                                    Get.dialog(VideoScreen(_homeController.videos['lessons'].reversed.toList()[(widget.index+1)],index:widget.index+1));
                                  }else{
                                  }
                                },
                              );
                            }else{
                              return Container();
                            }
                          }else{
                            return Container(

                            );
                          }
                        },
                      ),
                    )
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
        builder: (context) => Positioned(child: CupertinoControls(chewieController: Controller,backgroundColor: Color(0xff6a6a6a),iconColor: Colors.white,),));

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

    await Future.delayed(Duration(seconds: 3));

    overlayEntry.remove();
  }


}