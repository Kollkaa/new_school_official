import 'dart:io';

import 'package:dio/dio.dart' as dios;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class Backend {
  String baseUrl=GlobalConfiguration().getValue('base_url');
  final GetStorage storage = GetStorage();
  dios.Dio dio;
  String token;
  Backend({String token}){
    this.token=token;
    dio=new dios.Dio(dios.BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 3000,
      headers: {"Content-Type":"application/json",
    }
    )
    );

  }


  Future<dios.Response> signUp({String email,String pas})async{
    var response;
    response= dio.post("",data: {
      "type": "auth",
      "apiKey": "2xdCQ9nH",
      "email": email,
    "password": pas
    });

    return response;

  }

  Future<dios.Response> auth({String email,String pas}) {
    var response;
    response= dio.post("",data: {
      "type": "auth",
      "apiKey": "2xdCQ9nH",
      "email": email,
      "password": pas
    });
    return response;


  }

  Future<dios.Response> getMainCourse() {
    var response;
    response= dio.post("/api/api.php",data:dios.FormData.fromMap({'type': 'coursesindex',
        'apiKey': '2xdCQ9nH'
    }));
    return response;


  }

  Future<dios.Response> getCourse(id) {
    var response;
    response= dio.post("/api/api.php",data:dios.FormData.fromMap({'type': 'course',
      'apiKey': '2xdCQ9nH',
      'course_id':id
    }));
    return response;
  }

  Future<dios.Response> getVideos(id) {

    var response;
    response= dio.post("/api/api.php",data:dios.FormData.fromMap({'type': 'course_lessons',
      'apiKey': '2xdCQ9nH',
      'course_id':id
    }));
    return response;
  }

  Future<dios.Response> getMainCategories() {
    var response;
    response= dio.post("/api/api.php",data:dios.FormData.fromMap({'type': 'categories',
      'apiKey': '2xdCQ9nH'
    }));
    return response;

  }

  getCourseByCat(id) {
    var response;
    response= dio.post("/api/api.php",data:dios.FormData.fromMap({
      'type': 'course_category',
      'apiKey': '2xdCQ9nH',
      'category_id': id
    }));
    return response;
  }




}