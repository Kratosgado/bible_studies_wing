import 'package:bible_studies_wing/src/home/home_view.dart';
import 'package:bible_studies_wing/src/lesson/lesson_creator.dart';
import 'package:bible_studies_wing/src/screens/about_us.dart';
import 'package:bible_studies_wing/src/screens/living_stream.dart';
import 'package:bible_studies_wing/src/screens/my_people.dart';
import 'package:bible_studies_wing/src/screens/program_outline.dart';
import 'package:bible_studies_wing/src/screens/register.dart';
import 'package:flutter/material.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          title: "Bible Studies Wing",
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            primaryColor: Colors.red,
          ),
          darkTheme: ThemeData.light(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case AboutUs.routeName:
                    return const AboutUs();
                  case LivingStream.routeName:
                    return const LivingStream();
                  case MyPeopleScreen.routeName:
                    return const MyPeopleScreen();
                  case ProgramOutlineScreen.routeName:
                    return const ProgramOutlineScreen();
                  case RegisterScreen.routeName:
                    return const RegisterScreen();
                  case HomeView.routeName:
                    return HomeView();
                  case LessonCreator.routeName:
                    return const LessonCreator();
                  default:
                    // Check if the user is authenticated (signed in)
                    if (FirebaseAuth.instance.currentUser != null) {
                      return HomeView(); // If authenticated, return HomeView
                    } else {
                      return const RegisterScreen(); // If not authenticated, return RegisterScreen
                    }
                }
              },
            );
          },
        );
      },
    );
  }
}
