import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ost_ecommerce/app/controllers/auth_controller.dart';
import 'package:ost_ecommerce/core/services/network_caller.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(onUnAuthorize: _onUnAuthorize, accessToken: (){
    return Get.find<AuthController>().accessToken ?? '';
  });
}

Future<void> _onUnAuthorize() async {
  // TODO: remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
        (predicate) => false,
  );
}