import 'package:flutter/material.dart';
import 'package:ost_ecommerce/features/products/product_list_screen.dart';
import 'package:ost_ecommerce/features/shared/presentation/screens/bottom_nav_holder_screen.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verity_otp.dart';
import '../features/products/product_details_screen.dart';


MaterialPageRoute onGenerateRoute(RouteSettings settings){

  late Widget screen;

  if (settings.name == SplashScreen.name) {
    screen = SplashScreen();
  } else if (settings.name == SignInScreen.name) {
    screen = SignInScreen();
  } else if (settings.name == SignUpScreen.name) {
    screen = SignUpScreen();
  } else if (settings.name == VerifyOtpScreen.name) {
    final String email = settings.arguments as String;
    screen = VerifyOtpScreen(email: email );
  } else if (settings.name == BottomNavHolderScreen.name) {
    screen = BottomNavHolderScreen();
  }else if (settings.name == ProductListScreen.name) {
    final String category = settings.arguments as String;
    screen = ProductListScreen(categoryName: category,);
  }else if (settings.name == ProductDetailsScreen.name) {
    screen = ProductDetailsScreen();
  }


  return MaterialPageRoute(builder: (ctx) => screen);
}