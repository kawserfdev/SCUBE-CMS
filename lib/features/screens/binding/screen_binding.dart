import 'package:get/get.dart';
import '../controller/screen_controller.dart';

class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreenController>(() => ScreenController());
  }
}
