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
                  SizedBox(width: 15,),
                  Icon(Icons.arrow_back_ios,color: Color(0xff000000),),
                  SizedBox(width: 3,),
                  Text(
                    "Назад",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,fontFamily: 'Raleway'),
                  ),
                ],
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),

          ),
          body: Container(
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
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

                    ),
                    child:Stack(
                      children: [
                        ClipOval(
                          child: _image!=null?Image.file(_image,width: 120,height: 120,fit: BoxFit.cover,):_mainController.profile['avatar']!=null
                              ?Image.network("${_mainController.profile['avatar']}",height: 120,width: 120,fit: BoxFit.cover)
                              : SvgPicture.asset("assets/icons/Group 242.svg",height: 120,width: 120,fit: BoxFit.cover,)
                        ),
                        Container(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset("assets/icons/camera-2 1.svg"),
                              SizedBox(height: 10,)
                            ],
                          ),
                        )
                      ],
                    )
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
    return  Container(
        margin: EdgeInsets.only(bottom: 22,top: 20,left: 25,right: 25),
        child: FlatButton(
          padding: EdgeInsets.all(1),

          minWidth: Get.width-50,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Container(
        width: Get.width-50,
          height: 50,
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
      onPressed: ()async{
        var response= await Backend().editNameSurname(box.read("id"), _mainController.nameEditingController.text, _mainController.lastnameEditingController.text);
        var responces =await Backend().getUser(id:box.read("id"));
        _mainController.profile.value=responces.data['clients'][0];
         if(_image!=null){
           var responce=await Backend().editImage(box.read("id"),_image);

           var responces =await Backend().getUser(id:box.read("id"));
           _mainController.profile.value=responces.data['clients'][0];
           setState(() {
           });
         }
         Navigator.pop(context);
         Navigator.pop(context);

      },
    ));
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