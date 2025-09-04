import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ost_ecommerce/app/controller_binder.dart';
import 'package:ost_ecommerce/app/routes.dart';
import 'package:ost_ecommerce/l10n/app_localizations.dart';
import '../features/auth/presentation/screens/splash_screen.dart';

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
        return GetMaterialApp(
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
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          initialRoute: SplashScreen.name,
          onGenerateRoute: onGenerateRoute,
          initialBinding: ControllerBinding(),
        );
      },
    );
  }
}