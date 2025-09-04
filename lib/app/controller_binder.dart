import 'package:get/get.dart';

import '../features/shared/presentation/controllers/main_nav_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
  }
}