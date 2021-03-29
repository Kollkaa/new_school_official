import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
                  Expanded(child: WebView(
                    initialUrl: 'https://uk.wikipedia.org/wiki/%D0%A1%D0%BF%D1%80%D0%B0%D0%B2%D0%B0_%D0%AE%D0%9A%D0%9E%D0%A1%D0%B0',
                  ),)
                ]
            )
        )
    );

  }
}