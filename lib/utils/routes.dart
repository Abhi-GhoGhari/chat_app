import 'package:chat_app/presentation/page/alluser/alluser_page.dart';
import 'package:chat_app/presentation/page/notification_page/notification_page.dart';
import 'package:chat_app/presentation/page/signup_page/signup_page.dart';
import '../heders.dart';
import '../presentation/page/allfriends_page/allfriends_page.dart';
import '../presentation/page/home_page/home_page.dart';
import '../presentation/page/intro_page/intro_page.dart';
import '../presentation/page/login_page/login_page.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  String intropage = '/';
  String loginpage = 'login_page';
  String signuppage = 'signup_page';
  String homepage = 'home_page';
  String notificationpage = 'notification_page';
  String allfriendspage = 'allfriends_page';
  String alluserpage = 'alluser_page';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const IntroPage(),
    'signup_page': (context) => const SignupPage(),
    'home_page': (context) => const HomePage(),
    'login_page': (context) => const LoginPage(),
    'notification_page': (context) => const NotificationPage(),
    'allfriends_page': (context) => const AllFriendsPage(),
    'alluser_page': (context) => const AlluserPage(),
  };
}
