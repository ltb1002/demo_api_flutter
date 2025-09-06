import 'package:demo_test_api/screens/home_screen.dart';
import 'package:demo_test_api/screens/login_screen.dart';
import 'package:demo_test_api/screens/register_screen.dart';
import 'package:get/get.dart';
import 'package:demo_test_api/screens/welcome_screen.dart';
// import 'package:demo_test_api/screens/login_screen.dart';
// import 'package:demo_test_api/screens/register_screen.dart';
// import 'package:demo_test_api/screens/home_screen.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final routes = [
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
