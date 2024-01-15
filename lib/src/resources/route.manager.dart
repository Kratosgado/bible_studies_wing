import 'package:bible_studies_wing/src/screens/about_us/about_us_screen.dart';
import 'package:bible_studies_wing/src/screens/living_stream/living_stream.dart';
import 'package:bible_studies_wing/src/screens/my_people/my_people.dart';
import 'package:bible_studies_wing/src/screens/program_outline/program_outline.dart';
import 'package:bible_studies_wing/src/screens/auth/register.dart';
import 'package:bible_studies_wing/src/screens/splash/splash.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashRoute = '/';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String settingsRoute = '/settings';
  static const String aboutUsRoute = '/about-us';
  static const String livingStreamRoute = '/living-stream';
  static const String myPeopleRoute = '/my-people';
  static const String programOutlineRoute = '/program-outline';
  static const String lessonCreatorRoute = '/lesson-creator';
}

List<GetPage> getRoutes() => [
      GetPage(name: Routes.splashRoute, page: () => const SplashScreen()),
      // GetPage(name: Routes.settingsRoute, page: ()=> SettingsScreen(controller: controller))
      GetPage(name: Routes.aboutUsRoute, page: () => const AboutUsScreen()),
      GetPage(name: Routes.livingStreamRoute, page: () => const LivingStreamScreen()),
      GetPage(name: Routes.myPeopleRoute, page: () => const MyPeopleScreen()),
      GetPage(name: Routes.programOutlineRoute, page: () => const ProgramOutlineScreen()),
      GetPage(name: Routes.registerRoute, page: () => const RegisterScreen()),
    ];
