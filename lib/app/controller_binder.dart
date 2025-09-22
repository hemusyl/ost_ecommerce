import 'package:get/get.dart';
import 'package:ost_ecommerce/app/set_up_network_client.dart';
import 'package:ost_ecommerce/features/auth/presentation/controllers/sign_up_controller.dart';

import '../features/auth/presentation/controllers/verify_otp_controller.dart';
import '../features/shared/presentation/controllers/main_nav_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
  }
}