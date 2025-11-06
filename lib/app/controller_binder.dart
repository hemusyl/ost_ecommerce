import 'package:get/get.dart';
import 'package:ost_ecommerce/app/controllers/auth_controller.dart';
import 'package:ost_ecommerce/app/controllers/login_controller.dart';
import 'package:ost_ecommerce/app/set_up_network_client.dart';
import 'package:ost_ecommerce/features/auth/presentation/controllers/sign_up_controller.dart';
import 'package:ost_ecommerce/features/carts/controllers/cart_list_controller.dart';
import 'package:ost_ecommerce/features/home/presentation/controllers/home_slider_controller.dart';
import 'package:ost_ecommerce/features/shared/presentation/controllers/category_controller.dart';

import '../features/auth/presentation/controllers/verify_otp_controller.dart';
import '../features/shared/presentation/controllers/main_nav_controller.dart';
import '../features/shared/presentation/controllers/new_product_controller.dart';
import '../features/wish/controller/wishlist_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(LoginController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(CartListController());
    Get.put(NewProductController());
    Get.put(WishlistController());
  }
}