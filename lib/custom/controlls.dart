import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:dio/dio.dart' as dios;


import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:video_player/video_player.dart';

import 'cupProg.dart';
import 'form.dart';

class CupertinoControls extends StatefulWidget {


  CupertinoControls({
    this.chewieController,
    this.method,
    this.image,
    this.kurs_id,
    this.id,
    @required this.backgroundColor,
    @required this.iconColor,
  });
  var kurs_id;

  var id;
  var image;
  Function method;
  var chewieController;
  final Color backgroundColor;
  final Color iconColor;

  @override
  State<StatefulWidget> createState() {
    return _CupertinoControlsState();
  }
}

class _CupertinoControlsState extends State<CupertinoControls> {
  VideoPlayerValue _latestValue;
  double _latestVolume;
  bool _hideStuff = true;
  Timer _hideTimer;
  final marginSize = 5.0;
  Timer _expandCollapseTimer;
  Timer _initTimer;

  VideoPlayerController controller;
  ChewieController chewieController;
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    chewieController = widget.chewieController;
    if (_latestValue.hasError) {
      return chewieController.errorBuilder != null
          ? chewieController.errorBuilder(
        context,
        chewieController.videoPlayerController.value.errorDescription,
      )
          : Center(
        child: Icon(
          OpenIconicIcons.ban,
          color: Colors.white,
          size: 42,
        ),
      );
    }

    final backgroundColor = widget.backgroundColor;
    final iconColor = widget.iconColor;
    chewieController = widget.chewieController;
    controller = chewieController.videoPlayerController;
    final orientation = MediaQuery.of(context).orientation;
    final barHeight = orientation == Orientation.portrait ? 30.0 : 47.0;
    final buttonPadding = orientation == Orientation.portrait ? 16.0 : 24.0;

    return MouseRegion(
      onHover: (_) {
        _cancelAndRestartTimer();
      },
      child: GestureDetector(
        onTap: () {
          _cancelAndRestartTimer();
        },
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Column(
            children: <Widget>[
              _buildTopBar(
                  backgroundColor, iconColor, barHeight, buttonPadding),
              _buildHitArea(),
              widget.chewieController != null &&
                  widget.chewieController
                      .videoPlayerController.value.initialized
                  ?  Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      ValueListenableBuilder(
                        valueListenable:  widget.chewieController.videoPlayerController,
                        builder: (context, var value, child) {
                          if(value.position.inSeconds>= widget.chewieController.videoPlayerController.value.duration.inSeconds-15){
                           if(widget.image!=null) return  FlatButton(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Colors.black.withOpacity(0.04),
                                            image: DecorationImage(image: NetworkImage(
                                                widget.image
                                            ),fit: BoxFit.fill)
                                        ),),
                                      SizedBox(height: 5,),
                                      Text("Следующий урок",style: TextStyle(color: Colors.white),),

                                    ],
                                  ),
                                ),
                                onPressed: widget.method
                            );
                           else
                             return Container();

                          }else{
                            return Container();
                          }
                        },
                      ),
                      SizedBox(width: 15,)
                    ]
                ),
              ):Container(),
              _buildBottomBar(backgroundColor, iconColor, barHeight),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _expandCollapseTimer?.cancel();
    _initTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = widget.chewieController;
    controller = chewieController.videoPlayerController;

    if (_oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  AnimatedOpacity _buildBottomBar(
      Color backgroundColor,
      Color iconColor,
      double barHeight,
      ) {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 1.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(marginSize),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              height: barHeight,
              color: backgroundColor,
              child:  Row(
                children: <Widget>[
                  _buildSkipBack(iconColor, barHeight),
                  _buildPlayPause(controller, iconColor, barHeight),
                  _buildSkipForward(iconColor, barHeight),
                  _buildPosition(iconColor),
                  _buildProgressBar(),
                  _buildRemaining(iconColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLive(Color iconColor) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: Text(
        'LIVE',
        style: TextStyle(color: iconColor, fontSize: 12.0),
      ),
    );
  }

  GestureDetector _buildExpandButton(
      Color backgroundColor,
      Color iconColor,
      double barHeight,
      double buttonPadding,
      ) {
    return GestureDetector(
      onTap: _onExpandCollapse,
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0),
            child: Container(
              height: barHeight,
              padding: EdgeInsets.only(
                left: buttonPadding,
                right: buttonPadding,
              ),
              color: backgroundColor,
              child: Center(
                child: Icon(
                  chewieController.isFullScreen
                      ? OpenIconicIcons.fullscreenExit
                      : OpenIconicIcons.fullscreenEnter,
                  color: iconColor,
                  size: 12.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildHitArea() {
    return Expanded(
      child: GestureDetector(
        onTap: _latestValue != null && _latestValue.isPlaying
            ? _cancelAndRestartTimer
            : () {
          _hideTimer?.cancel();

          setState(() {
            _hideStuff = false;
          });
        },
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  GestureDetector _buildMuteButton(
      VideoPlayerController controller,
      Color backgroundColor,
      Color iconColor,
      double barHeight,
      double buttonPadding,
      ) {
    return GestureDetector(
      onTap: () {
        _cancelAndRestartTimer();

        if (_latestValue.volume == 0) {
          controller.setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = controller.value.volume;
          controller.setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0),
            child: Container(
              color: backgroundColor,
              child: Container(
                height: barHeight,
                padding: EdgeInsets.only(
                  left: buttonPadding,
                  right: buttonPadding,
                ),
                child: Icon(
                  (_latestValue != null && _latestValue.volume > 0)
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: iconColor,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  GestureDetector _buildBackButton(
      VideoPlayerController controller,
      Color backgroundColor,
      Color iconColor,
      double barHeight,
      double buttonPadding,
      ) {
    return GestureDetector(
      onTap: () {

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
              widget.kurs_id,
              widget.id,
              value,
              chewieController.videoPlayerController.value.duration.inSeconds);
          print(res.data);
          if(box.read('id')!=null){
            _mainController.initProfile(box.read("id"));
          }
        });
        controller.add(1);
        setState(() {
        });

        setState(() {
        });
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0),
            child: Container(
              color: backgroundColor,
              child: Container(
                height: barHeight,
                padding: EdgeInsets.only(
                  left: buttonPadding,
                  right: buttonPadding,
                ),
                child: Icon(
                  Icons.clear,
                  color: iconColor,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  GestureDetector _buildPlayPause(
      VideoPlayerController controller,
      Color iconColor,
      double barHeight,
      ) {
    return GestureDetector(
      onTap: _playPause,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 6.0,
          right: 6.0,
        ),
        child: Icon(
          controller.value.isPlaying
              ? OpenIconicIcons.mediaPause
              : OpenIconicIcons.mediaPlay,
          color: iconColor,
          size: 16.0,
        ),
      ),
    );
  }

  Widget _buildPosition(Color iconColor) {
    final position =
    _latestValue != null ? _latestValue.position : Duration(seconds: 0);
    return Container(
      width: 50,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child:Text(
          formatDuration(position),
          style: TextStyle(
            color: iconColor,
            fontSize: 12.0,
          ),
        ),
        onPressed: (){},
      ),
    );
  }

  Widget _buildRemaining(Color iconColor) {
    final position = _latestValue != null && _latestValue.duration != null
        ? _latestValue.duration - _latestValue.position
        : Duration(seconds: 0);

    return FlatButton(
      padding: EdgeInsets.all(0),
      child:Text(
        '-${formatDuration(position)}',
        style: TextStyle(color: iconColor, fontSize: 12.0),
      ),);
  }

  GestureDetector _buildSkipBack(Color iconColor, double barHeight) {
    return GestureDetector(
      onTap: _skipBack,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        margin: EdgeInsets.only(left: 10.0,right: 10),
        padding: EdgeInsets.only(
          left: 6.0,
          right: 6.0,
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.skewY(0.0)
            ..rotateX(math.pi)
            ..rotateZ(math.pi),
          child: Icon(
            OpenIconicIcons.reload,
            color: iconColor,
            size: 12.0,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSkipForward(Color iconColor, double barHeight) {
    return GestureDetector(
      onTap: _skipForward,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 6.0,
          right: 8.0,
        ),
        margin: EdgeInsets.only(
          right: 8.0,left: 10
        ),
        child: Icon(
          OpenIconicIcons.reload,
          color: iconColor,
          size: 12.0,
        ),
      ),
    );
  }

  Widget _buildTopBar(
      Color backgroundColor,
      Color iconColor,
      double barHeight,
      double buttonPadding,
      ) {
    return Container(
      height: barHeight,
      margin: EdgeInsets.only(
        top: marginSize,
        right: marginSize,
        left: marginSize,
      ),
      child: Row(
        children: <Widget>[
      chewieController.allowMuting
      ?              _buildBackButton(
          controller, backgroundColor, iconColor,
          barHeight, buttonPadding)
              : Container(),
          Expanded(child: Container()),
          chewieController.allowMuting
              ? _buildMuteButton(controller, backgroundColor, iconColor,
              barHeight, buttonPadding)
              : Container(),
        ],
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();

    setState(() {
      _hideStuff = false;

      _startHideTimer();
    });
  }

  Future<Null> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if ((controller.value != null && controller.value.isPlaying) ||
        chewieController.autoPlay) {
      _startHideTimer();
    }

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(Duration(milliseconds: 200), () {
        setState(() {
          _hideStuff = false;
        });
      });
    }
  }

  void _onExpandCollapse() {
    setState(() {
      _hideStuff = true;

      chewieController.toggleFullScreen();
      _expandCollapseTimer = Timer(Duration(milliseconds: 300), () {
        setState(() {
          _cancelAndRestartTimer();
        });
      });
    });
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CupertinoVideoProgressBar(
          controller,
          onDragStart: () {
            _hideTimer?.cancel();
          },
          onDragEnd: () {
            _startHideTimer();
          },
          colors: chewieController.cupertinoProgressColors ??
              ChewieProgressColors(
                playedColor: Color.fromARGB(
                  120,
                  255,
                  255,
                  255,
                ),
                handleColor: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ),
                bufferedColor: Color.fromARGB(
                  60,
                  255,
                  255,
                  255,
                ),
                backgroundColor: Color.fromARGB(
                  20,
                  255,
                  255,
                  255,
                ),
              ),
        ),
      ),
    );
  }

  void _playPause() {
    bool isFinished;
    if (_latestValue.duration != null) {
      isFinished = _latestValue.position >= _latestValue.duration;
    } else {
      isFinished = false;
    }

    setState(() {
      if (controller.value.isPlaying) {
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
        StreamController<int> controllers = StreamController<int>();
        Stream stream = controllers.stream;
        stream.listen((value) async{
          var res=await Backend().setPos(
              widget.kurs_id,
              widget.id,
              value,
              chewieController.videoPlayerController.value.duration.inSeconds);
          print(res.data);
        });
        controllers.add(2);
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.initialized) {
          controller.initialize().then((_) {
            controller.play();
          });
        } else {
          if (isFinished) {
            controller.seekTo(Duration(seconds: 0));
          }
          controller.play();
        }
      }
    });
  }

  void _skipBack() {
    _cancelAndRestartTimer();
    final beginning = Duration(seconds: 0).inMilliseconds;
    final skip = (_latestValue.position - Duration(seconds: 10)).inMilliseconds;
    controller.seekTo(Duration(milliseconds: math.max(skip, beginning)));
  }

  void _skipForward() {
    _cancelAndRestartTimer();
    final end = _latestValue.duration.inMilliseconds;
    final skip = (_latestValue.position + Duration(seconds: 10)).inMilliseconds;
    controller.seekTo(Duration(milliseconds: math.min(skip, end)));
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _updateState() {
    setState(() {
      _latestValue = controller.value;
    });
  }
}