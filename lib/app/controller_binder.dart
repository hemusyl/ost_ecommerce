import 'package:get/get.dart';
import 'package:ost_ecommerce/app/set_up_network_client.dart';

import '../features/shared/presentation/controllers/main_nav_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
  }
}