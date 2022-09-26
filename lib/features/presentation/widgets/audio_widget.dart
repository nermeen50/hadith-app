import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/formate.dart';

class AudioWidget extends StatelessWidget {
  final double maxValue;
  final double sliderValue;
  final Function(double) onChanged;
  final Duration sliderTimer;
  final Widget playIcon;
  final VoidCallback kPlayPress;
  const AudioWidget(
      {Key? key,
      required this.maxValue,
      required this.sliderValue,
      required this.onChanged,
      required this.sliderTimer,
      required this.playIcon,
      required this.kPlayPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Slider(
              min: 0.0,
              max: maxValue,
              activeColor: AppColors.yellow,
              inactiveColor: AppColors.offWhite,
              value: sliderValue,
              onChanged: onChanged),
          const SizedBox(height: 15),
          Text(formatDuration(sliderTimer)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: SvgPicture.asset(AppAssets.skipForwardShape)),
              IconButton(onPressed: kPlayPress, icon: playIcon),
              Expanded(child: SvgPicture.asset(AppAssets.skipBackShape)),
            ],
          )
        ],
      ),
    );
  }
}
