import 'package:get/get.dart';
import '../controller/screen_controller.dart';

class SourceDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SourceDataController>(() => SourceDataController());
  }
}
