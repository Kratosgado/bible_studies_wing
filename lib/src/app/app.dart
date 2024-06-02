import 'package:bible_studies_wing/src/resources/theme_manager.dart';
import 'package:bible_studies_wing/src/resources/route.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      theme: getApplicationTheme(),
      // darkTheme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      getPages: getRoutes(),
    );
  }
}
