import 'package:bible_studies_wing/src/screens/about_us/about.us.screen.dart';
import 'package:bible_studies_wing/src/screens/auth/membership.form.screen.dart';
import 'package:bible_studies_wing/src/screens/gallery/gallery.screen.dart';
import 'package:bible_studies_wing/src/screens/home/home.screen.dart';
import 'package:bible_studies_wing/src/screens/lesson/lesson_creator.dart';
import 'package:bible_studies_wing/src/screens/lesson/lesson_detail.dart';
import 'package:bible_studies_wing/src/screens/living_stream/living_stream.dart';
import 'package:bible_studies_wing/src/screens/my_people/member_profile.dart';
import 'package:bible_studies_wing/src/screens/my_people/my_people.dart';
import 'package:bible_studies_wing/src/screens/program_outline/program_outline.dart';
import 'package:bible_studies_wing/src/screens/auth/register.screen.dart';
import 'package:bible_studies_wing/src/screens/splash/splash.dart';
import 'package:get/get.dart';

class Routes {
  // auth
  static const String splashRoute = '/';
  static const String registerRoute = '/register';
  static const String membershipFormRoute = '/membership-form';
  static const String memberProfileRoute = '/member-profile';

  // home
  static const String homeRoute = '/home';
  static const String settingsRoute = '/settings';
  static const String aboutUsRoute = '/about-us';
  static const String livingStreamRoute = '/living-stream';
  static const String myPeopleRoute = '/my-people';
  static const String programOutlineRoute = '/program-outline';
  static const String galleryRoute = '/gallery';

  // lesson
  static const String lessonCreatorRoute = '/lesson-creator';
  static const String lessonDetailRoute = '/lesson-detail';
}

List<GetPage> getRoutes() => [
      // auth
      GetPage(name: Routes.splashRoute, page: () => const SplashScreen()),
      GetPage(name: Routes.membershipFormRoute, page: () => MemberRegistrationForm()),
      GetPage(name: Routes.memberProfileRoute, page: () => MemberProfileScreen()),
      // GetPage(name: Routes.settingsRoute, page: ()=> SettingsScreen(controller: controller))

      // home
      GetPage(name: Routes.homeRoute, page: () => HomeScreen()),

      GetPage(name: Routes.aboutUsRoute, page: () => const AboutUsScreen()),
      GetPage(name: Routes.livingStreamRoute, page: () => const LivingStreamScreen()),
      GetPage(name: Routes.myPeopleRoute, page: () => const MyPeopleScreen()),
      GetPage(name: Routes.programOutlineRoute, page: () => const ProgramOutlineScreen()),
      GetPage(name: Routes.registerRoute, page: () => const RegisterScreen()),
      GetPage(name: Routes.galleryRoute, page: () => const GalleryScreen()),

      // lesson
      GetPage(name: Routes.lessonCreatorRoute, page: () => const LessonCreatorScreen()),
      GetPage(name: Routes.lessonDetailRoute, page: () => LessonDetailScreen()),
    ];
