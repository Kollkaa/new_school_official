import 'dart:convert';

import 'package:async/async.dart';
import 'package:dio/dio.dart' as dios;
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Backend {
  String baseUrl = GlobalConfiguration().getValue('base_url');
  final GetStorage storage = GetStorage();
  dios.Dio dio;
  String token;

  Backend({String token}) {
    this.token = token;
    dio = new dios.Dio(dios.BaseOptions(baseUrl: baseUrl, headers: {
      "Content-Type": "application/json",
    }));
  }
  var getFinishedCoursesResponse;
  var getUservideoTimeAllResponse;
  var getUserVideoTimeResponse;
  var getUserResponse;
  var getUserVideoCabResponse;

  Future<dios.Response> signUp({String email, String pas}) async {
    var response;
    response = dio.post("/api/api.php", data: {
      "type": "auth",
      "apiKey": "2xdCQ9nH",
      "email": email,
      "password": pas
    });

    return response;
  }

  Future getUser({String id}) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "client_info",
          "apiKey": "2xdCQ9nH",
          "client_id": id,
        }));
    getUserResponse = response.data;

    return response.data;
  }

  Future getUservideo_time_all({String id}) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "client_video_time_all",
          "apiKey": "2xdCQ9nH",
          "client_id": id,
        }));
    getUservideoTimeAllResponse = response.data;
    return response.data;
  }

  Future getUservideo_cab({String id}) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "client_video_cab",
          "apiKey": "2xdCQ9nH",
          "client_id": id,
        }));
    getUserVideoCabResponse = response.data;
    return response.data;
  }

  Future getUservideo_time({String id}) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "client_video_time",
          "apiKey": "2xdCQ9nH",
          "client_id": id,
        }));
    getUserVideoTimeResponse = response.data;
    return response.data;
  }

  Future<dios.Response> auth({String email, String pas}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "auth",
          "apiKey": "2xdCQ9nH",
          "email": email,
          "password": pas
        }));
    return response;
  }

  Future<dios.Response> register({String email, String pas}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': "register",
          "apiKey": "2xdCQ9nH",
          "email": email,
          "password": pas
        }));
    return response;
  }

  Future<dios.Response> getMainCourse() {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'coursesindex', 'apiKey': '2xdCQ9nH'}));
    return response;
  }

  Future<dios.Response> getGetVideo(id) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'lesson', 'apiKey': '2xdCQ9nH', 'lesson_id': id}));
    return response;
  }

  Future<dios.Response> editNameSurname(id, name, surname) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_edit_name',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          'client_name': name,
          'client_lastname': surname
        }));
    return response;
  }

  Future<dios.Response> editEmail(id, email) {
    return dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_edit_email',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          'client_email': email
        }));
    ;
  }

  Future<dios.Response> editPassword(id, pass) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_edit_password',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          'client_password': pass
        }));
    return response;
  }

  Future<dios.Response> getCourse(id) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'course', 'apiKey': '2xdCQ9nH', 'course_id': id}));
    return response;
  }

  Future<dios.Response> getVideos(id) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'course_lessons', 'apiKey': '2xdCQ9nH', 'course_id': id}));
    return response;
  }

  Future<dios.Response> getMainCategories() {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'categories', 'apiKey': '2xdCQ9nH'}));
    return response;
  }

  Future<dios.Response> getStatCourse(course_id) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'course_stats',
          'apiKey': '2xdCQ9nH',
          'course_id': course_id
        }));
    return response;
  }

  Future<dios.Response> createPayment(email) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'create_payment',
          'apiKey': '2xdCQ9nH',
          'client_email': email
        }));
    return response;
  }

  Future<dios.Response> getStatusPayment(email) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'payment_status',
          'apiKey': '2xdCQ9nH',
          'client_email': email
        }));
    return response;
  }

  getCourseByCat(id) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'course_category',
          'apiKey': '2xdCQ9nH',
          'category_id': id
        }));
    return response;
  }

  editImage(id, imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseUrl + "/api/api.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFileSign = new http.MultipartFile(
        'client_avatar', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFileSign);
    request.fields['type'] = 'client_edit_avatar';
    request.fields['client_id'] = id;
    request.fields['apiKey'] = '2xdCQ9nH';
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {});
    if (response.statusCode == 200) {}
  }

  getStat({id}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'client_stats', 'apiKey': '2xdCQ9nH', 'client_id': id}));
    return response;
  }

  setPos(course_id, lesson_id, value, video_duration) async {
    var response;
    // print({
    //   'type': 'client_view_lesson',
    //   'apiKey': '2xdCQ9nH',
    //   'client_id': storage.read('id'),
    //   'lesson_id': lesson_id,
    //   'course_id': course_id,
    //   'video_time': value,
    //   'video_duration': video_duration,
    // });
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_view_lesson',
          'apiKey': '2xdCQ9nH',
          'client_id': storage.read('id'),
          'lesson_id': lesson_id,
          'course_id': course_id,
          'video_time': value,
          'video_duration': video_duration,
        }));

    return response.data;
  }

  getTestStat({id, course_id}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'test_stats',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          "course_id": course_id
        }));
    return response;
  }

  getTestByidCourse({course_id}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'test_course',
          'apiKey': '2xdCQ9nH',
          "course_id": course_id
        }));
    return response;
  }

  sendQuery({id, course_id, question_id, answer_id}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'test_answer',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          "course_id": course_id,
          'question_id': question_id,
          "answer_id": answer_id
        }));
    return response;
  }

  startTest({id, course_id}) {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'test_start',
          'apiKey': '2xdCQ9nH',
          'client_id': id,
          "course_id": course_id
        }));
    return response;
  }

  getAllCourses() {
    var response;
    response = dio.post("/api/api.php",
        data: dios.FormData.fromMap(
            {'type': 'courses_all', 'apiKey': '2xdCQ9nH'}));
    return response;
  }

  Future getFinishedCourses(client_id) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_course_stats',
          'apiKey': '2xdCQ9nH',
          'client_id': client_id
        }));
    getFinishedCoursesResponse = response.data;
    return response.data;
  }

  Future getVideoStat(clientId, courseId) async {
    var response;
    response = await dio.post("/api/api.php",
        data: dios.FormData.fromMap({
          'type': 'client_course_stats_lessons',
          'apiKey': '2xdCQ9nH',
          'course_id': courseId,
          'client_id': clientId,
        }));
    return response.data;
  }
}
