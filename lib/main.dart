import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

import 'routes/app_pages.dart';
import 'storage/colors/main_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GlobalConfiguration().loadFromAsset("configurations.json");

  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(new Localizations(
    locale: const Locale('en', 'US'),
    delegates: <LocalizationsDelegate<dynamic>>[
      DefaultWidgetsLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      color: Colors.white,
      theme: ThemeData(primaryColor: white_color, backgroundColor: white_color),
      defaultTransition: Transition.rightToLeft,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages().getRoutes(),
    ),
  ));
}
