import 'dart:async';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/custom/controlls.dart';
import 'package:new_school_official/moduls/home/controllers/home_controller.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/routes/app_pages.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart' as dios;

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
  MainController _mainController = Get.find();
  ChewieController _chewieController;
  final GetStorage box = GetStorage();
  var oldPos=0;
  @override
  void initState() {
    super.initState();
    initializePlayer();
    oldPos=widget.duration!=null?widget.duration:0;
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
  VideoPlayerController videoPlayerController= new VideoPlayerController.network("dataSource");
  Future<void> initializePlayer() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setState(( ) { } );
    print(widget.lesson['videos'][0]['video_url']);
    if(Get.height>1920){
      if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")>=0){
        print('"quality": "720"');

        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")>=0){
        print('"quality": "480"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")]['video_url']
        );
      }else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")>=0){
        print('"quality": "1080"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")]['video_url']
        );
      }
    }else if (Get.height>=2560){
      if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")>=0){
        print('"quality": "1080"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")>=0){
        print('"quality": "720"');

        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")>=0){
        print('"quality": "480"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")]['video_url']
        );
      }
    }else if (Get.height>=4096){
      if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")>=0){
        print('"quality": "1080"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")>=0){
        print('"quality": "720"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")>=0){
        print('"quality": "480"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")]['video_url']
        );
      }
    }else{
      if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")>=0){
        print('"quality": "480"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="480")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")>=0){
        print('"quality": "720"');

        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="720")]['video_url']
        );
      } else if(widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")>=0){
        print('"quality": "1080"');
        videoPlayerController =new VideoPlayerController.network(
            widget.lesson['videos'][widget.lesson['videos'].indexWhere((el)=>el['quality']=="1080")]['video_url']
        );
      }
    }
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      startAt: Duration(seconds: widget.duration!=null?widget.duration:0),
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
    _chewieController.videoPlayerController.addListener(() {
      if(_mainController.auth.value)
        if(_chewieController.videoPlayerController.value.position.inSeconds==_chewieController.videoPlayerController.value.duration.inSeconds){
          myOverayEntry.remove();
          _chewieController.videoPlayerController.removeListener(() {});
          _chewieController.removeListener(() {});
          _chewieController.videoPlayerController.dispose();
          _chewieController.dispose();
          setState(() {

          });
          Get.back();
          if((widget.index+1)<=_homeController.videos['lessons'].length-1){
            Get.to(VideoScreen(_homeController.videos['lessons'].reversed.toList()[(widget.index+1)],index:widget.index+1));
          }else{
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white
            ));
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            setState(() {
            });
            Get.toNamed(Routes.TEST);

          }

        }
    });
    myOverayEntry = getMyOverlayEntry(context: context);
    Overlay.of(context).insert(myOverayEntry);
    setState(( ) { } );
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
            image:_mainController.auth.value?((_homeController.videos['lessons'].length-1)>=(widget.index+1))?_homeController.videos['lessons'].reversed.toList()[widget.index+1]['video_image']:null:null,
            iconColor: Colors.white,
            id:  _homeController.videos['lessons'].reversed.toList()[(widget.index)]['id'],
            kurs_id:  _homeController.videos['lessons'].reversed.toList()[(widget.index)]['kurs_id'],
            method:(){
              myOverayEntry.remove();
              _chewieController..videoPlayerController.removeListener(() {});
              _chewieController.removeListener(() {});
              _chewieController.videoPlayerController.dispose();
              _chewieController.dispose();
              Get.back();
              if(_mainController.auth.value){
                if((widget.index+1)<=_homeController.videos['lessons'].length-1){
                  print("12");
                  Get.to(VideoScreen(_homeController.videos['lessons'].reversed.toList()[(widget.index+1)],index:widget.index+1));
                }else{
                  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.white
                  ));
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                  setState(() {
                  });
                  Get.toNamed(Routes.TEST);
                  print("123");
                }
              }
            },),));
  }
  @override
  Widget build(BuildContext context) {
    try{
      return new WillPopScope(
          onWillPop: () {
            Get.back();
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,SystemUiOverlay.top]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white
            ));
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            StreamController<int> controller = StreamController<int>();
            Stream stream = controller.stream;
            stream.listen((value) async{
              dios.Response getUservideo_time_all =await Backend().getUservideo_time_all(id:box.read('id'));
              _mainController.getUservideo_time_all.value=getUservideo_time_all.data['lessons'];

              var res=await Backend().setPos(
                  _homeController.videos['lessons'].reversed.toList()[(widget.index)]['kurs_id'],
                  _homeController.videos['lessons'].reversed.toList()[(widget.index)]['id'],
                  value,
                  _chewieController.videoPlayerController.value.duration.inSeconds);
              print(res.data);
              if(box.read('id')!=null){
                _mainController.initProfile(box.read("id"));
              }
            });
            controller.add(oldPos);
            setState(() {
            });
            return Future<bool>(( )=>true);
          },
          child:MaterialApp(

            home: Container(
              color: Colors.black,
              child: Center(
                // child:  BetterPlayer(
                //   controller: _betterPlayerController,
                // ),
                child: _chewieController != null &&
                    _chewieController
                        .videoPlayerController.value.initialized
                    ?  AspectRatio(
                  aspectRatio: 16/8,
                  child: Chewie(

                    controller: _chewieController,
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ));
    }catch(e){
      return Container();
    }
  }
  showOverlay(BuildContext context,Controller) async {


  }


}