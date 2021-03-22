import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'routes/app_pages.dart';
import 'storage/colors/main_color.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  await GlobalConfiguration().loadFromAsset("configurations.json");

  await GetStorage.init();


  runApp(
      new Localizations(
  locale: const Locale('en', 'US'),
  delegates: <LocalizationsDelegate<dynamic>>[
  DefaultWidgetsLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  ],
      child:  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),

        theme: ThemeData(
          primaryColor: white_color,
          backgroundColor: white_color
        ),
        defaultTransition: Transition.rightToLeft,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages().getRoutes(),
      ),)
  );
}
