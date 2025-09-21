import 'package:flutter/material.dart';
import 'package:ost_ecommerce/core/services/network_caller.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(onUnAuthorize: _onUnAuthorize, accessToken: '');
}

Future<void> _onUnAuthorize() async {
  // TODO: remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
        (predicate) => false,
  );
}