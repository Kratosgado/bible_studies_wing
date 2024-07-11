import 'package:bible_studies_wing/src/screens/about_us/about.us.screen.dart';
import 'package:bible_studies_wing/src/screens/announcement/add.announce.dart';
import 'package:bible_studies_wing/src/screens/announcement/announcement.screen.dart';
import 'package:bible_studies_wing/src/screens/auth/membership.form.screen.dart';
import 'package:bible_studies_wing/src/screens/gallery/gallery.screen.dart';
import 'package:bible_studies_wing/src/screens/home/home.screen.dart';
import 'package:bible_studies_wing/src/screens/lesson/add.lesson.dart';
import 'package:bible_studies_wing/src/screens/lesson/lesson_detail.dart';
import 'package:bible_studies_wing/src/screens/living_stream/living_stream.dart';
import 'package:bible_studies_wing/src/screens/my_people/add.past.executive.dart';
import 'package:bible_studies_wing/src/screens/my_people/member_profile.dart';
import 'package:bible_studies_wing/src/screens/my_people/my_people.dart';
import 'package:bible_studies_wing/src/screens/my_people/past.executives.dart';
import 'package:bible_studies_wing/src/screens/program_outline/add.outline.dart';
import 'package:bible_studies_wing/src/screens/program_outline/program_outline.dart';
import 'package:bible_studies_wing/src/screens/auth/register.screen.dart';
import 'package:bible_studies_wing/src/screens/splash/splash.dart';
import 'package:bible_studies_wing/src/screens/todays_event/add.todays.event.dart';
import 'package:bible_studies_wing/src/screens/todays_event/todays.event.dart';
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
  static const String pastExecutivesRoute = '/pastExecutives';
  static const String addPastExecutivesRoute = '/addPastExecutives';
  static const String galleryRoute = '/gallery';

  // program outline
  static const String programOutlineRoute = '/program-outline';
  static const String addProgramOutlineRoute = '/add-program-outline';

  // lesson
  static const String lessonCreatorRoute = '/lesson-creator';
  static const String lessonDetailRoute = '/lesson-detail';

  // today's event
  static const String todaysEventRoute = '/todays-event';
  static const String addtodaysEventRoute = '/add-todays-event';

  // announcement
  static const String announcementRoute = "/announcemtent";
  static const String addAnnouncementRoute = "/add-announcement";
}

List<GetPage> getRoutes() => [
      // auth
      GetPage(name: Routes.splashRoute, page: () => const SplashScreen()),
      GetPage(name: Routes.membershipFormRoute, page: () => MemberRegistrationForm()),
      GetPage(name: Routes.memberProfileRoute, page: () => const MemberProfileScreen()),
      // GetPage(name: Routes.settingsRoute, page: ()=> SettingsScreen(controller: controller))

      // home
      GetPage(name: Routes.homeRoute, page: () => const HomeScreen()),

      GetPage(name: Routes.aboutUsRoute, page: () => const AboutUsScreen()),
      GetPage(name: Routes.livingStreamRoute, page: () => const LivingStreamScreen()),
      GetPage(name: Routes.myPeopleRoute, page: () => const MyPeopleScreen()),
      GetPage(name: Routes.pastExecutivesRoute, page: () => const PastExecutivesScreen()),
      GetPage(name: Routes.addPastExecutivesRoute, page: () => const AddPastExecutiveScreen()),
      GetPage(name: Routes.registerRoute, page: () => const RegisterScreen()),
      GetPage(name: Routes.galleryRoute, page: () => const GalleryScreen()),

      // program outline
      GetPage(name: Routes.programOutlineRoute, page: () => const ProgramOutlineScreen()),
      GetPage(name: Routes.addProgramOutlineRoute, page: () => AddProgramOutlineScreen()),

      // lesson
      GetPage(name: Routes.lessonCreatorRoute, page: () => AddLessonScreen()),
      GetPage(name: Routes.lessonDetailRoute, page: () => LessonDetailScreen()),

      // today's event
      GetPage(name: Routes.todaysEventRoute, page: () => const TodayEventScreen()),
      GetPage(name: Routes.addtodaysEventRoute, page: () => const AddEventScreen()),

      // announcement
      GetPage(name: Routes.announcementRoute, page: () => const AnnouncementScreen()),
      GetPage(name: Routes.addAnnouncementRoute, page: () => AddAnnouncementScreen()),
    ];
