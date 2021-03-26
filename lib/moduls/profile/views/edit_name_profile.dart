import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_school_official/moduls/main/controllers/main_controller.dart';
import 'package:new_school_official/service/backend.dart';

class EditProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateEdit();
  }

}
class StateEdit extends State<EditProfile>{
  MainController _mainController = Get.find();
  final GetStorage box = GetStorage();

  bool imageChange=false;



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leadingWidth: 120,
            leading: GestureDetector(
              child: Row(
                children: [
                  SizedBox(width: 11,),
                  Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                  SizedBox(width: 3,),
                  Text(
                    "Назад",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                  ),
                ],
              ),
              onTap: (){
                Get.back();
              },
            ),

          ),
          body: Container(
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(50, 50, 71, 0.08),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(
                                  0,0
                              )
                          )
                        ],
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image:_image!=null?FileImage(_image):_mainController.profile['avatar']!=null
                                ?NetworkImage("${_mainController.profile['avatar']}")
                                : AssetImage("assets/images/60 x 60.jpg",)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/icons/camera-2 1.svg")
                      ],
                    ),
                  ),
                  onTap: ()async{
                    await getImage();


                  },
                ),
                makeTextFieldLog(),
                makeTextFieldPass(),
                makeButton()
              ],
            ),
          ),
        )
    );
  }

  Widget makeTextFieldLog(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(left: 25,right: 25,top: 36),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Color(0xffEBEBEB)
          )
      ),
      child:TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000).withOpacity(0.8)
        ),

        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Имя",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)
          ),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),

        controller: _mainController.nameEditingController,

      ),

    );
  }

  Widget makeTextFieldPass(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),

      margin: EdgeInsets.only(left: 25,right: 25,top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: Color(0xffEBEBEB)
          )
      ),
      child:TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000).withOpacity(0.8)
        ),

        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Фамилия",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffc4c4c4)
          ),
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),

        controller: _mainController.lastnameEditingController,

      ),

    );
  }

  Widget makeButton(){
    return GestureDetector(
      child: Container(
          height: 50,
          margin: EdgeInsets.only(left: 25,right: 25,bottom: 22,top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1,
                  color: Color(0xff000000)
              )
          ),
          child: Center(
            child: Text(
              "Сохранить",
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,height: 1,fontFamily: "Raleway"),
            ),
          )
      ),
      onTap: ()async{
        var response= await Backend().editNameSurname(box.read("id"), _mainController.nameEditingController.text, _mainController.lastnameEditingController.text);
        print(response.data);
        var responces =await Backend().getUser(id:box.read("id"));
        _mainController.profile.value=responces.data['clients'][0];

         if(_image!=null){
           var responce=await Backend().editImage(box.read("id"),_image);
           var responces =await Backend().getUser(id:box.read("id"));
           print(responces);
           _mainController.profile.value=responces.data['clients'][0];
           setState(() {
           });
         }
      },
    );
  }
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {

        });
      } else {
        print('No image selected.');
      }
    });
  }
}