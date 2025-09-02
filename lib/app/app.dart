import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ost_ecommerce/l10n/app_localizations.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verity_otp.dart';
import 'app_theme.dart';
import 'controllers/language_controller.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  static final LanguageController languageController = LanguageController();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {

  //Analytics Setup
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CraftyBay.languageController,
      builder: (languageController) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorObservers: [observer],
          locale: languageController.currentLocale,
          supportedLocales: languageController.supportedLocales,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          themeMode: ThemeMode.light,
          home: SplashScreen(),
          initialRoute: SplashScreen.name,
          onGenerateRoute: (settings){
            late Widget screen;

            if (settings.name == SplashScreen.name) {
              screen = SplashScreen();
            } else if (settings.name == SignInScreen.name) {
              screen = SignInScreen();
            } else if (settings.name == SignUpScreen.name) {
              screen = SignUpScreen();
            } else if (settings.name == VerifyOtpScreen.name) {
              screen = VerifyOtpScreen();
            }

            return MaterialPageRoute(builder: (ctx) => screen);
          },
        );
      },
    );
  }
}