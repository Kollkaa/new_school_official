import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:new_school_official/storage/colors/main_color.dart';
import 'package:new_school_official/storage/styles/text_style.dart';

class BottomNavigationitem{
  showItem(bool pageActive, String type, double sizeIcon,{String text}){
    return BottomNavigationBarItem(
        icon:Center(
          child: new Stack(
            children: <Widget>[
              Center(
                child:  Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 14,),
                      SvgPicture.asset('assets/icons/${type}',
                        color:  pageActive!=null?pageActive?Colors.black:timer_color:timer_color,
                        height: sizeIcon,
                      ),
                      SizedBox(height: 3,),
                      text!=null
                          ?Text(text, style: pageActive!=null?pageActive?enable_style_text_bottom:disenable_style_text_bottom:disenable_style_text_bottom)
                          :Container(),
                    ],
                  ),
                ),
              ),
              // pageActive!=null?pageActive?Positioned(
              //     top: 0,left: 0,right: 0,
              //     child: Center(
              //       child: Container(
              //         width: 50,
              //         height: 3,
              //         color: Colors.black,
              //       ),
              //     )
              // ):Container():Container()
            ],
          ),
        ),
      title: Container()
    );
  }

}