import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/config/routes/app_route.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  _goNextPage() => Navigator.pushReplacementNamed(context, Routes.homeRoute);
  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 2000), () => _goNextPage());
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(AppAssets.splashBackground, fit: BoxFit.cover),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.appLogo),
              const SizedBox(height: 30),
              const Text(AppStrings.appName, style: TextStyle(fontSize: 36))
            ],
          )
        ],
      ),
    );
  }
}
