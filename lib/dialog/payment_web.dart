import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/service/backend.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart' as dios;

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  MainController _mainController=Get.find();
  final GetStorage box = GetStorage();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    inirUrl();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // Enable hybrid composition.
  }
  var res;
  inirUrl()async{
    res=await Backend().createPayment(_mainController.email);
    print(res);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white_color,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 27,bottom: 10),
                    child:GestureDetector(
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                          Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                          SizedBox(width: 3,),
                          Text(
                            "Назад",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                      onTapDown: (_){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                 res!=null? res.data[0]['url']!=null?Expanded(child: WebView(
                   javascriptMode: JavascriptMode.unrestricted,
                   onWebViewCreated: (WebViewController webViewController) {
                     _controller.complete(webViewController);
                   },
                   onPageStarted: (String url)async {
                     print('Page started loading: $url');
                     if(url.contains("https://school.webfirst.rv.ua")){
                       dios.Response responce =await Backend().auth(email: _mainController.email.value,pas: _mainController.password.value);
                       print(responce);
                       if(responce.statusCode==200&&!responce.data[0]['error']){
                         print(responce.data);
                         await box.write("auth", true);
                         _mainController.profile={}.obs;
                         print(responce.data);
                         print(responce.data[0]);
                         print(responce.data[0]['id']);
                         await box.write("id", responce.data[0]['id']);
                         dios.Response responces =await Backend().getUser(id:responce.data[0]['id']);

                         dios.Response getUservideo_cab =await Backend().getUservideo_cab(id:responce.data[0]['id']);
                         dios.Response getUservideo_time =await Backend().getUservideo_time(id:responce.data[0]['id']);
                         dios.Response getUservideo_time_all =await Backend().getUservideo_time_all(id:responce.data[0]['id']);
                         dios.Response getStats =await Backend().getStat(id:responce.data[0]['id']);
                         _mainController.profile.value=responces.data['clients'][0];
                         _mainController.getStats.value=getStats.data['user_stats'][0];
                         _mainController.getUservideo_cab.value=getUservideo_cab.data['lessons_cabinet'];
                         _mainController.getUservideo_time.value=getUservideo_time.data['lessons'];
                         _mainController.getUservideo_time_all.value=[];
                         _mainController.getUservideo_time_all.addAll(getUservideo_time_all.data['lessons']);                         print(responces.data['clients'][0]['name']);
                         _mainController.auth.value=true;
                         _mainController.widgets.removeAt(4);
                         _mainController.widgets.add(ProfilePage());
                         setState(() {

                         });
                       }
                       Get.back();
                       Get.back();
                       Get.back();
                     }
                   },
                   initialUrl:  res.data[0]['url'],
                 ),):Container():Container()
                ]
            )
        )
    );

  }
}