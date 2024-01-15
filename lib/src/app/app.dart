import 'package:bible_studies_wing/src/screens/home/home_view.dart';
import 'package:bible_studies_wing/src/screens/lesson/lesson_creator.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:bible_studies_wing/src/screens/about_us/about_us_screen.dart';
import 'package:bible_studies_wing/src/screens/living_stream/living_stream.dart';
import 'package:bible_studies_wing/src/screens/my_people/my_people.dart';
import 'package:bible_studies_wing/src/screens/program_outline/program_outline.dart';
import 'package:bible_studies_wing/src/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/settings/settings_controller.dart';
import '../screens/settings/settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return GetMaterialApp(
      title: "Bible Studies Wing",
      
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
      ),
      darkTheme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      getPages: getRoutes(),
    );
  }
}
