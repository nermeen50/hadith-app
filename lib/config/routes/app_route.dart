import 'package:flutter/material.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/presentation/screens/hadith_favourite/hadith_favourite_sceen.dart';
import 'package:hadith_app/features/presentation/screens/hadith_listen_screens/hadith_listen_details_screen.dart';
import 'package:hadith_app/features/presentation/screens/hadith_listen_screens/hadith_listen_screen.dart';
import 'package:hadith_app/features/presentation/screens/hadith_screens/hadith_details_screen.dart';
import 'package:hadith_app/features/presentation/screens/hadith_screens/hadith_screen.dart';
import 'package:hadith_app/features/presentation/screens/home_screen.dart';
import 'package:hadith_app/features/presentation/screens/splash_screen.dart';

class Routes {
  static const String intialRoute = '/';
  static const String homeRoute = '/home';
  static const String hadithRoute = '/hadith';
  static const String hadithDetailsRoute = '/hadithDetails';
  static const String hadithListenRoute = '/hadithListen';
  static const String hadithListenDetailsRoute = '/hadithListenDetails';
  static const String hadithFavouriteRoute = '/hadithFavourite';
}

class AppRoute {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.intialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.hadithRoute:
        return MaterialPageRoute(builder: (_) => const HadithScreen());
      case Routes.hadithDetailsRoute:
        final hadith = routeSettings.arguments as HadithEntity;
        return MaterialPageRoute(
            builder: (_) => HadithDetailsScreen(hadithDetails: hadith));
      case Routes.hadithListenRoute:
        return MaterialPageRoute(builder: (_) => const HadithListenScreen());
      case Routes.hadithListenDetailsRoute:
        final hadith = routeSettings.arguments as HadithEntity;
        return MaterialPageRoute(
            builder: (_) => HadithListenDetailsScreen(hadithDetails: hadith));
      case Routes.hadithFavouriteRoute:
        return MaterialPageRoute(builder: (_) => const HadithFavouriteScreen());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Text(AppStrings.noRouteFound),
      );
    });
  }
}
