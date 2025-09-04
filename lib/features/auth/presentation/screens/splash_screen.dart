import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ost_ecommerce/app/extensions/localization_extension.dart';
import 'package:ost_ecommerce/features/auth/presentation/screens/utils/app_version_service.dart';
import 'package:ost_ecommerce/features/shared/presentation/screens/bottom_nav_holder_screen.dart';


import '../../../../app/asset_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, BottomNavHolderScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              SvgPicture.asset(AssetPaths.logoSvg, width: 120),
              Spacer(),
              CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(
                '${context.localization.version} '
                    '${AppVersionService.currentAppVersion}',
              ),
            ],
          ),
        ),
      ),
    );
  }

}