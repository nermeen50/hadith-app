import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/config/routes/app_route.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/presentation/widgets/home_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
        child: Stack(children: [
          SvgPicture.asset(AppAssets.homeBackground, fit: BoxFit.cover),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Center(
                        child: SvgPicture.asset(AppAssets.appGreenLogo))),
                const SizedBox(height: 30),
                const Text(AppStrings.appName, style: TextStyle(fontSize: 15)),
                const SizedBox(height: 8),
                const Text(AppStrings.homeHeader,
                    style: TextStyle(color: AppColors.primary)),
                const SizedBox(height: 30),
                Expanded(
                  child: HomeCardWidget(
                      kPress: () =>
                          Navigator.of(context).pushNamed(Routes.hadithRoute),
                      cardLeadingImage: AppAssets.homeIcon1,
                      cardContent: AppStrings.homeCartOne,
                      cardTrailingImage: AppAssets.quranImage,
                      cardBackground: [
                        AppColors.darkPrimary.withOpacity(0.9),
                        AppColors.primary,
                        // Colors.yellow,
                      ]),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: HomeCardWidget(
                      kPress: () => Navigator.of(context)
                          .pushNamed(Routes.hadithListenRoute),
                      cardLeadingImage: AppAssets.homeIcon2,
                      cardContent: AppStrings.homeCartTwo,
                      cardTrailingImage: AppAssets.playImage,
                      cardBackground: [
                        AppColors.violent.withOpacity(0.7),
                        AppColors.yellow,
                      ]),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: HomeCardWidget(
                      kPress: () => Navigator.of(context)
                          .pushNamed(Routes.hadithFavouriteRoute),
                      cardLeadingImage: AppAssets.homeIcon3,
                      cardContent: AppStrings.homeCartThree,
                      cardTrailingImage: AppAssets.saveImage,
                      cardBackground: [
                        AppColors.violent,
                        AppColors.redDark.withOpacity(0.7),
                      ]),
                ),
              ]),
        ]),
      ),
    );
  }
}
