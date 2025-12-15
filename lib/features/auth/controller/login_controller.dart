import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }
}
