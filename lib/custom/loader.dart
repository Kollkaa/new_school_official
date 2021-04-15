import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Shimmer.fromColors(
            highlightColor: Colors.grey,
            baseColor: Colors.black,
            child: Text("NEW SCHOOL",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.w700,letterSpacing: 0.7),),
            period: Duration(milliseconds: 800),
          ),
        )
      )
    );
  }

}
class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 280;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}