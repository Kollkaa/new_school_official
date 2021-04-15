import 'dart:convert';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/custom/controlls.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:video_player/video_player.dart';

class ListVideo extends StatefulWidget {
  var course;
  var title;
  ListVideo(this.course,this.title);

  @override
  State<StatefulWidget> createState() {
    return ListVideoState();
  }
}
class ListVideoState extends State<ListVideo>{
  MainController mainController =Get.find();
  ChewieController _chewieController;

  @override
  void initState() {

  }



  @override
  Widget build(BuildContext context) {
    var count=0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 170,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.arrow_back_ios),
              Text("Назад",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color:Colors.black,fontFamily: "Raleway"))
            ],
          ),
          onTapDown: (_){
            Get.back();
          },
        )
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          SizedBox(height: 32,),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("${widget.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color:Colors.black,fontFamily: "Raleway"))
          ),
          SizedBox(height: 22,),

          ...widget.course.split("||").map((el){
            count+=1;
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 61,
                      width: 93,
                      margin: EdgeInsets.only(bottom: 21,left: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage("${jsonDecode(el)['image']}")
                          )
                      ),
                    ),
                    SizedBox(width: 18,),
                    Container(
                      height: 61,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("$count. ${jsonDecode(el)['title']}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black,fontFamily: "Raleway"),),
                          SizedBox(height: 4,),
                          Container(
                            width: Get.width-170,
                            child: Text("${jsonDecode(el)['desc']}",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w300,color:Color(0xff6A6A6A),fontFamily: "Raleway")),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTapDown: (_)async{
                await Get.to(Video(jsonDecode(el)['video']));
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
              },
            );
          }).toList()
        ],
      ),
    );
  }

}
class Video extends StatefulWidget {
  var path;

  Video(this.path);

  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}
class VideoState extends State<Video> {
  MainController mainController = Get.find();
  ChewieController _chewieController;

  initPlayer()async{
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black
    ));
    setState(() {

    });
    var dir = await getApplicationDocumentsDirectory();
    VideoPlayerController videoplayer=new VideoPlayerController.file(
        new File("${dir.path}${widget.path}"));

    await videoplayer.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoplayer,
      aspectRatio: 16/9,
      autoInitialize: true,
      autoPlay: true,
      showControlsOnInitialize: false,
      showControls: false,
      allowFullScreen: false,
      fullScreenByDefault: false,
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
      setState(( ) { } );

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
      builder: (context) => _chewieController.videoPlayerController!=null?Positioned(
        child: CupertinoControls(
          chewieController: _chewieController,
          backgroundColor: Color(0xff232323),
          image:null,
          iconColor: Colors.white,
          id:  null,
          kurs_id:  null,
          method:(){
            myOverayEntry.remove();
            _chewieController.videoPlayerController.removeListener(() {});
            _chewieController.removeListener(() {});
            _chewieController.videoPlayerController.dispose();
            _chewieController.dispose();
            Get.back();},
        ),
      ):Container()
  );
  }
  @override
  void initState() {
    initPlayer();
  }

  @override
  void dispose() {
    myOverayEntry.remove();
    _chewieController.videoPlayerController.removeListener(() {});
    _chewieController.removeListener(() {});
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    print(widget.path);
    return Container(
      height: Get.height,
      width: Get.height,
      child:_chewieController != null &&
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
    );
  }

}