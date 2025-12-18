import 'package:get/get.dart';
import 'package:scubecms/features/home/view/analysis_screen.dart';
import '../features/home/view/home_screen.dart';
import '../features/auth/view/login_screen.dart';
import '../features/auth/binding/login_binding.dart';
import '../features/sources/view/source_data_view.dart';
import '../features/sources/binding/screen_binding.dart';
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
      name: AppRoutes.sourceDataView,
      page: () => const SourceDataView(),
      binding: SourceDataBinding(),
    ),
    GetPage(name: AppRoutes.analysis, 
    page:()=> AnalysisScreen(), 
    )
  ];
}
