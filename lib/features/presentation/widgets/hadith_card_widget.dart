import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';

class HadithCardWidget extends StatelessWidget {
  final String hadithTitle;
  final String hadithSubTitle;
  final VoidCallback? kPress;
  const HadithCardWidget(
      {Key? key,
      required this.hadithTitle,
      required this.hadithSubTitle,
      this.kPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: kPress,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(AppAssets.hadithBackgroundShape),
          SvgPicture.asset(AppAssets.hadithforgroundShape),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(hadithTitle,
                    style:
                        const TextStyle(color: AppColors.yellow, fontSize: 12)),
                const SizedBox(height: 5),
                Text(hadithSubTitle,
                    style:
                        const TextStyle(color: AppColors.yellow, fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
