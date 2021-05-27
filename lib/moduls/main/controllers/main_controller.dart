import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/home/views/home.dart';
import 'package:new_school_official/moduls/main/views/download_page.dart';
import 'package:new_school_official/moduls/profile/views/profile.dart';
import 'package:new_school_official/moduls/search/views/search_view.dart';
import 'package:new_school_official/moduls/static/views/static_view.dart';
import 'package:new_school_official/service/backend.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var image = File("1").obs;
  final GetStorage box = GetStorage();
  RxBool auth = true.obs;
  RxList widgets = [].obs;

  RxBool banner = true.obs;

  var profile = {}.obs;

  var phoneEditingController = new TextEditingController();

  var passEditingController = new TextEditingController();

  // ignore: non_constant_identifier_names
  var getUservideo_cab = [].obs;

  // ignore: non_constant_identifier_names
  var getUservideo_time = [].obs;

  // ignore: non_constant_identifier_names
  var getUservideo_time_all = [].obs;

  var getStats = {}.obs;

  var lastnameEditingController = new TextEditingController();

  var nameEditingController = new TextEditingController();

  var passEditEditingController = new TextEditingController();

  var passOldEditingController = new TextEditingController();

  var passConfEditingController = new TextEditingController();

  var emailConfEditEditingController = new TextEditingController();

  var emailEditEditingController = new TextEditingController();

  var password = "".obs;

  var email = "".obs;
  StreamController<dynamic> controller = StreamController<dynamic>();
  // ignore: close_sinks
  StreamController<dynamic> materialController = StreamController<dynamic>();
  Stream stream;
  Stream materialStream;

  var listValue = Map();
  var materialValue = Map();

  var downloads;

  var allCourse = [];

  var searchCourse = [].obs;

  var finishedCourses = [].obs;

  var controllerSearch = new TextEditingController();
  var listContCourse = [].obs;

  @override
  void onInit() async {
    super.onInit();
    downloads = box.read("downloads");
    stream = controller.stream;
    stream.listen((value) async {
      CancelToken cancelToken = CancelToken();
      await downloadFile(
          value['url'],
          value['course_id'],
          value['course'],
          value['video_id'],
          value['video'],
          value['downloaded'],
          value['onDownloadError'],
          cancelToken);
    });
    materialStream = materialController.stream;
    materialStream.listen((value) async {
      CancelToken cancelToken = CancelToken();
      await downloadMaterial(
          value["url"],
          value["course_id"],
          value["material_id"],
          value["material"],
          value["downloaded"],
          value["onDownloadError"],
          cancelToken);
    });

    allCourse = (await Backend().getAllCourses()).data['kurses'];
    auth.value = await box.read("auth");
    if (box.read("id") != null) {
      initProfile(box.read("id"));
      Get.appUpdate();
    } else {
      auth.value = auth.value != null ? auth.value : false;
      // ignore: deprecated_member_use, deprecated_member_use, invalid_use_of_protected_member
      widgets.value = [
        HomePage(),
        SearchScreen(),
        StaticScreen(),
        DownloadPage(),
        auth.value ? ProfilePage() : AuthPage(),
      ];
    }
  }

  Future initProfile(id) async {
    getUservideo_time = [].obs;
    listContCourse = [].obs;
    Backend backend = Backend();
    await Future.wait([
      backend.getFinishedCourses(id),
      backend.getUservideo_time_all(id: id),
      backend.getUservideo_time(id: id),
      backend.getUservideo_cab(id: id),
      backend.getUser(id: id)
    ]);

    if (backend.getFinishedCoursesResponse
        .toString()
        .contains("ended_courses")) {
      finishedCourses
          .addAll(backend.getFinishedCoursesResponse['ended_courses']);
    } else {
      // ignore: deprecated_member_use, invalid_use_of_protected_member
      finishedCourses.value = [];
    }
    // ignore: deprecated_member_use, invalid_use_of_protected_member
    this.getUservideo_time_all.value = [];
    this.getUservideo_time_all.addAll(
        backend.getUservideoTimeAllResponse['lessons'] != null
            ? backend.getUservideoTimeAllResponse['lessons']
            : []);
    // ignore: deprecated_member_use, invalid_use_of_protected_member
    this.getUservideo_time.value = [];
    this.getUservideo_time.addAll(
        backend.getUserVideoTimeResponse['lessons'] != null
            ? backend.getUserVideoTimeResponse['lessons']
            : []);

    // ignore: deprecated_member_use, deprecated_member_use, invalid_use_of_protected_member
    profile.value = backend.getUserResponse['clients'][0];
    nameEditingController = new TextEditingController(text: profile['name']);
    lastnameEditingController =
        new TextEditingController(text: profile['lastname']);
    if (getUservideo_time.length != 0) {
      getUservideo_time.forEach((element) {
        if (finishedCourses
                .where((el) => el['course_id'] == element['course_id'])
                .length !=
            0) {
        } else {
          listContCourse.add(element);
        }
      });
    }
    // print("listContCourse ${listContCourse}");
    // ignore: deprecated_member_use, invalid_use_of_protected_member
    this.getUservideo_cab.value =
        backend.getUserVideoCabResponse['lessons_cabinet'];
    auth.value = auth.value != null ? auth.value : false;
    // ignore: deprecated_member_use, invalid_use_of_protected_member
    widgets.value = [
      HomePage(),
      SearchScreen(),
      StaticScreen(),
      DownloadPage(),
      auth.value ? ProfilePage() : AuthPage(),
    ];
    Get.appUpdate();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    auth.close();
    controller.close();
    super.onClose();
  }

  void onIndexChanged(input) {
    currentIndex.value = input;
    downloads = box.read("downloads");
  }

  Future downloadFile(String url, courseId, _course, videoId, video,
      Function downloaded, Function onDownloadError, cancelToken) async {
    String downloadID = courseId.toString() + videoId.toString();
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      listValue[downloadID] = {
        "rec": 1,
        "total": 1,
        "progress": num.parse((1 / 1).toStringAsFixed(2)),
        "download": true,
        "cancelToken": cancelToken
      };
      await dio.download(url, "${dir.path}/$courseId/$videoId.mp4",
          onReceiveProgress: (rec, total) async {
        listValue[downloadID] = {
          "rec": rec,
          "total": total,
          "progress": num.parse((rec / total).toStringAsFixed(4)),
          "download": true,
          "cancelToken": cancelToken
        };
        Get.appUpdate();
        if (rec == total) {
          listValue.remove(downloadID);
          var downloads = box.read("downloads");
          var course = box.read("$courseId");
          if (downloads == null) {
            box.write(
                "downloads",
                jsonEncode({
                  "id": "$courseId",
                  "image": "${_course['banner_small']}",
                  "title": "${_course['topic']}",
                  "desc": "${_course['description']}"
                }));
            if (course == null) {
              box.write(
                  "$courseId",
                  jsonEncode({
                    "id": "$videoId",
                    "image": "${video['video_image']}",
                    "title": "${video['video_name']}",
                    "desc": "${video['video_description']}",
                    "video": "/$courseId/$videoId.mp4"
                  }));
            } else {
              if (course.toString().indexOf("${jsonEncode({
                        "id": "$videoId",
                        "image": "${video['video_image']}",
                        "title": "${video['video_name']}",
                        "desc": "${video['video_description']}",
                        "video": "/$courseId/$videoId.mp4"
                      })}") >=
                  0) {
              } else {
                box.write(
                    "$courseId",
                    '$course||${jsonEncode({
                      "id": "$videoId",
                      "image": "${video['video_image']}",
                      "title": "${video['video_name']}",
                      "desc": "${video['video_description']}",
                      "video": "/$courseId/$videoId.mp4"
                    })}');
              }
            }
          } else {
            if (downloads.toString().indexOf("${jsonEncode({
                      "id": "$courseId",
                      "image": "${_course['banner_small']}",
                      "title": "${_course['topic']}",
                      "desc": "${_course['description']}"
                    })}") >=
                0) {
            } else {
              await box.write(
                  "downloads",
                  '$downloads||${jsonEncode({
                    "id": "$courseId",
                    "image": "${_course['banner_small']}",
                    "title": "${_course['topic']}",
                    "desc": "${_course['description']}"
                  })}');
            }
            if (course == null) {
              box.write(
                  "$courseId",
                  jsonEncode({
                    "id": "$videoId",
                    "image": "${video['video_image']}",
                    "title": "${video['video_name']}",
                    "desc": "${video['video_description']}",
                    "video": "/$courseId/$videoId.mp4"
                  }));
            } else {
              if (course.toString().indexOf("${jsonEncode({
                        "id": "$videoId",
                        "image": "${video['video_image']}",
                        "title": "${video['video_name']}",
                        "desc": "${video['video_description']}",
                        "video": "/$courseId/$videoId.mp4"
                      })}") >=
                  0) {
              } else {
                box.write(
                    "$courseId",
                    '$course||${jsonEncode({
                      "id": "$videoId",
                      "image": "${video['video_image']}",
                      "title": "${video['video_name']}",
                      "desc": "${video['video_description']}",
                      "video": "/$courseId/$videoId.mp4"
                    })}');
              }
            }
          }
        }
      }, cancelToken: cancelToken);
    } catch (e) {}
    try {
      downloaded();
    } catch (e) {
      onDownloadError();
    }
    Get.appUpdate();
  }

  Future downloadMaterial(String url, courseId, materialId, material,
      Function downloaded, Function onDownloadError, cancelToken) async {
    String downloadID = courseId.toString() + materialId.toString();
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      materialValue[downloadID] = {
        "rec": 1,
        "total": 1,
        "progress": num.parse((1 / 1).toStringAsFixed(2)),
        "download": true,
        "cancelToken": cancelToken
      };
      await dio.download(url, "${dir.path}/material$courseId/$materialId",
          onReceiveProgress: (rec, total) async {
        materialValue[downloadID] = {
          "rec": rec,
          "total": total,
          "progress": num.parse((rec / total).toStringAsFixed(4)),
          "download": true,
          "cancelToken": cancelToken
        };
        Get.appUpdate();
        if (rec == total) {
          materialValue.remove(downloadID);
          var downloads = box.read("downloadsMaterial");
          var course = box.read("material$courseId");
          if (downloads == null) {
            box.write("downloadsMaterial", jsonEncode({"id": "$courseId"}));
            if (course == null) {
              box.write(
                  "material$courseId",
                  jsonEncode({
                    "id": "$materialId",
                    "title": "${material['material_name']}",
                    "file": "/material$courseId/$materialId"
                  }));
            } else {
              if (course.toString().indexOf("${jsonEncode({
                        "id": "$materialId",
                        "title": "${material['material_name']}",
                        "file": "/material$courseId/$materialId"
                      })}") >=
                  0) {
              } else {
                box.write(
                    "material$courseId",
                    '$course||${jsonEncode({
                      "id": "$materialId",
                      "title": "${material['material_name']}",
                      "file": "/material$courseId/$materialId"
                    })}');
              }
            }
          } else {
            if (downloads.toString().indexOf("${jsonEncode({
                      "id": "$materialId",
                      "title": "${material['material_name']}",
                      "file": "/material$courseId/$materialId"
                    })}") >=
                0) {
            } else {
              await box.write("downloadsMaterial",
                  '$downloads||${jsonEncode({"id": "$courseId"})}');
            }
            if (course == null) {
              box.write(
                  "material$courseId",
                  jsonEncode({
                    "id": "$materialId",
                    "title": "${material['material_name']}",
                    "file": "/material$courseId/$materialId"
                  }));
            } else {
              if (course.toString().indexOf("${jsonEncode({
                        "id": "$materialId",
                        "title": "${material['material_name']}",
                        "file": "/material$courseId/$materialId"
                      })}") >=
                  0) {
              } else {
                box.write(
                    "material$courseId",
                    '$course||${jsonEncode({
                      "id": "$materialId",
                      "title": "${material['material_name']}",
                      "file": "/material$courseId/$materialId"
                    })}');
              }
            }
          }
        }
      }, cancelToken: cancelToken);
    } catch (e) {
      onDownloadError();
    }
    try {
      downloaded();
    } catch (err) {}
    Get.appUpdate();
  }

  getVideo(course) {
    return box.read("$course");
  }

  void onChange(String value) {
    // ignore: deprecated_member_use, invalid_use_of_protected_member
    searchCourse.value = [];
    var search = allCourse
        .where((element) =>
            element['topic'].toLowerCase().contains(value.toLowerCase()))
        .toList();
    searchCourse.addAll(search);
    Get.appUpdate();
  }
}
