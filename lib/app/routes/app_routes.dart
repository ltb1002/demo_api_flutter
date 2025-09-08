import 'package:demo_test_api/screens/forgotPass_screen.dart';
import 'package:demo_test_api/screens/home_screen.dart';
import 'package:demo_test_api/screens/login_screen.dart';
import 'package:demo_test_api/screens/register_screen.dart';
import 'package:demo_test_api/screens/resetPass_screen.dart';
import 'package:demo_test_api/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const forgotpass = '/forgotpass';
  static const resetpass = '/resetpass';

  static final routes = [
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: forgotpass, page: () => ForgotPasswordScreen()),
    GetPage(
      name: resetpass,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final email = args?['email'] ?? '';
        final token = args?['token'] ?? '';
        return ResetPasswordScreen(email: email, token: token);
      },
    ),
  ];
}
