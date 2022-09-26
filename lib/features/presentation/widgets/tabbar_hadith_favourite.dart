import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/config/routes/app_route.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:hadith_app/features/presentation/widgets/audio_widget.dart';
import 'package:hadith_app/features/presentation/widgets/hadith_card_widget.dart';

class TabbarHadithFavourite extends StatelessWidget {
  final TabController tabController;
  final List<HadithEntity> tabarData;
  const TabbarHadithFavourite(
      {Key? key, required this.tabController, required this.tabarData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(color: AppColors.black)),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: AppColors.primary),
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.black,
              tabs: const [
                Tab(text: AppStrings.homeCartOne),
                Tab(text: AppStrings.homeCartTwo),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(controller: tabController, children: [
            // first tab bar view widget
            tabarData.isEmpty
                ? const Center(child: Text(AppStrings.noItemInFav))
                : GridView.builder(
                    itemCount: tabarData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => HadithCardWidget(
                        kPress: () => Navigator.of(context).pushNamed(
                            Routes.hadithListenDetailsRoute,
                            arguments: tabarData[index]),
                        hadithTitle: tabarData[index].id.toString(),
                        hadithSubTitle: tabarData[index].name.toString()),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  ),
            // second tab bar view widget

            tabarData.isEmpty
                ? const Center(child: Text(AppStrings.noItemInFav))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabarData.length,
                    itemBuilder: (context, index) {
                      return BlocBuilder<HadithCubit, HadithState>(
                          builder: (ctx, state) {
                        ctx.watch<HadithCubit>().changeListAudio(index);

                        return Card(
                          color: AppColors.primary,
                          child: AudioWidget(
                              maxValue: ctx
                                  .watch<HadithCubit>()
                                  .durationList[index]
                                  .inSeconds
                                  .toDouble(),
                              sliderValue: ctx
                                  .watch<HadithCubit>()
                                  .positionList[index]
                                  .inSeconds
                                  .toDouble(),
                              onChanged: (value) => ctx
                                  .read<HadithCubit>()
                                  .seekToSecondList(index, value.toInt()),
                              sliderTimer:
                                  ctx.watch<HadithCubit>().positionList[index],
                              playIcon: ctx
                                          .watch<HadithCubit>()
                                          .advancedPlayerList![index]
                                          .state ==
                                      PlayerState.playing
                                  ? const Icon(Icons.pause, size: 40)
                                  : const Icon(Icons.play_arrow_outlined,
                                      size: 40),
                              kPlayPress: () => ctx
                                          .read<HadithCubit>()
                                          .advancedPlayerList![index]
                                          .state ==
                                      PlayerState.playing
                                  ? ctx.read<HadithCubit>().pauseList(index)
                                  : ctx.read<HadithCubit>().advancedPlayerList![index].state ==
                                          PlayerState.paused
                                      ? ctx
                                          .read<HadithCubit>()
                                          .resumeList(index)
                                      : ctx
                                          .read<HadithCubit>()
                                          .playList(index, tabarData[index].audio)),
                        );
                      });
                    })
          ])),
        ],
      ),
    );
  }
}
