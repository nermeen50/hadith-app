import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:hadith_app/features/presentation/widgets/audio_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hadith_app/injection_container.dart' as di;

class HadithListenDetailsScreen extends StatefulWidget {
  final HadithEntity hadithDetails;
  const HadithListenDetailsScreen({Key? key, required this.hadithDetails})
      : super(key: key);

  @override
  State<HadithListenDetailsScreen> createState() =>
      _HadithListenDetailsScreenState();
}

class _HadithListenDetailsScreenState extends State<HadithListenDetailsScreen> {
  SharedPreferences sharedPreferences = di.sl<HadithCubit>().sharedPreferences;

  @override
  void initState() {
    BlocProvider.of<HadithCubit>(context).initPlayer();
    BlocProvider.of<HadithCubit>(context)
        .knowFavouriteHadith(widget.hadithDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Stack(children: [
          SvgPicture.asset(AppAssets.homeBackground, fit: BoxFit.cover),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<HadithCubit>(context).stopAudio();
                    // BlocProvider.of<HadithCubit>(context).releaseAudio();
                  },
                  icon: SvgPicture.asset(AppAssets.arrowBack)),
              title: SvgPicture.asset(AppAssets.appGreenLogo),
            ),
            Text(widget.hadithDetails.name,
                style: const TextStyle(color: AppColors.primary)),
            const SizedBox(height: 30),
            Expanded(
                child: Center(
              child: SvgPicture.asset(AppAssets.listenShape),
            )),
            ListTile(
              trailing: BlocBuilder<HadithCubit, HadithState>(
                  buildWhen: (previous, current) {
                return current is FavouriteHadithRemove ||
                    current is FavouriteHadithLoaded;
              }, builder: (context, state) {
                if (state is FavouriteHadithRemove ||
                    context.watch<HadithCubit>().favItem) {
                  return IconButton(
                      icon:
                          const Icon(Icons.favorite, color: AppColors.redDark),
                      onPressed: () => context
                          .read<HadithCubit>()
                          .removeHadithToFavourite(widget.hadithDetails));
                } else {
                  return IconButton(
                      onPressed: () => context
                          .read<HadithCubit>()
                          .addHadithToFavourite(widget.hadithDetails),
                      icon: SvgPicture.asset(AppAssets.heartIcon));
                }
              }),
              title: Text(widget.hadithDetails.id,
                  style: const TextStyle(color: AppColors.black)),
              subtitle: Text(widget.hadithDetails.name,
                  style: const TextStyle(color: AppColors.primary)),
            ),
            const SizedBox(height: 15),
            BlocBuilder<HadithCubit, HadithState>(builder: (context, state) {
              return AudioWidget(
                  onChanged: (value) => BlocProvider.of<HadithCubit>(context)
                      .seekToSecond(value.toInt()),
                  maxValue: context
                      .watch<HadithCubit>()
                      .duration
                      .inSeconds
                      .toDouble(),
                  sliderValue: context
                      .watch<HadithCubit>()
                      .position
                      .inSeconds
                      .toDouble(),
                  sliderTimer: context.watch<HadithCubit>().position,
                  playIcon: (state is HadithPauseAudio)
                      ? const Icon(Icons.pause, size: 40)
                      : const Icon(Icons.play_arrow_outlined, size: 40),
                  kPlayPress: () => (state is HadithPauseAudio)
                      ? context.read<HadithCubit>().pause()
                      : (state is HadithResumeAudio)
                          ? context.read<HadithCubit>().resume()
                          : context
                              .read<HadithCubit>()
                              .play(widget.hadithDetails.audio));
            }),
          ]),
        ]),
      ),
    );
  }
}
