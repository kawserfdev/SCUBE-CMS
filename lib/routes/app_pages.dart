import 'package:get/get.dart';

import '../features/home/view/home_screen.dart';
import '../features/auth/view/login_screen.dart';
import '../features/auth/binding/login_binding.dart';
import '../features/screens/view/screen_one.dart';
import '../features/screens/view/screen_two.dart';
import '../features/screens/view/screen_three.dart';
import '../features/screens/view/screen_four.dart';
import '../features/screens/binding/screen_binding.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage<dynamic>>[
    GetPage<dynamic>(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.screen1,
      page: () => const ScreenOne(),
      binding: ScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.screen2,
      page: () => const ScreenTwo(),
      binding: ScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.screen3,
      page: () => const ScreenThree(),
      binding: ScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.screen4,
      page: () => const ScreenFour(),
      binding: ScreenBinding(),
    ),
  ];
}
