import 'package:get/get.dart';
import 'package:new_school_official/moduls/auth/bindings/auth_binding.dart';
import 'package:new_school_official/moduls/auth/views/auth.dart';
import 'package:new_school_official/moduls/course/bindings/course_binding.dart';
import 'package:new_school_official/moduls/course/views/course_view.dart';
import 'package:new_school_official/moduls/home/bindings/home_binding.dart';
import 'package:new_school_official/moduls/home/views/home.dart';
import 'package:new_school_official/moduls/main/bindings/main_binding.dart';
import 'package:new_school_official/moduls/main/views/main_view.dart';
import 'package:new_school_official/moduls/test/bindings/test_binding.dart';
import 'package:new_school_official/moduls/test/views/test_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAIN;
  var strings;

  AppPages({this.strings});

  getRoutes() {
    return [
      GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
        transitionDuration: Duration(microseconds: 500),
      ),
      GetPage(
        name: Routes.MAIN,
        page: () => MainScreen(),
        binding: MainBinding(),
        transitionDuration: Duration(microseconds: 500),
      ),
      GetPage(
        name: Routes.AUTH,
        page: () => AuthPage(),
        binding: AuthBinding(),
        transitionDuration: Duration(microseconds: 500),
      ),
      GetPage(
        name: Routes.COURSE,
        page: () => CourseScreen(),
        binding: CourseBinding(),
        transitionDuration: Duration(microseconds: 500),
      ),
      GetPage(
        name: Routes.TEST,
        page: () => TestScreen(),
        binding: TestBinding(),
        transitionDuration: Duration(microseconds: 500),
      ),
    ];
  }
}
