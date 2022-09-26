import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/config/routes/app_route.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:hadith_app/features/presentation/widgets/hadith_card_widget.dart';

class HadithListenScreen extends StatefulWidget {
  const HadithListenScreen({Key? key}) : super(key: key);

  @override
  State<HadithListenScreen> createState() => _HadithListenScreenState();
}

class _HadithListenScreenState extends State<HadithListenScreen> {
  @override
  void initState() {
    BlocProvider.of<HadithCubit>(context).getHadithData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Stack(
          children: [
            SvgPicture.asset(AppAssets.homeBackground, fit: BoxFit.cover),
            BlocBuilder<HadithCubit, HadithState>(
                buildWhen: (previous, current) {
              return current is HadithLoaded;
            }, builder: (context, state) {
              if (state is HadithLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HadithError) {
                return Center(child: Text(state.massage));
              } else if (state is HadithLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: SvgPicture.asset(AppAssets.arrowBack)),
                      title: SvgPicture.asset(AppAssets.appGreenLogo),
                    ),
                    const Text(AppStrings.homeCartTwo,
                        style: TextStyle(color: AppColors.primary)),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.hadithEntity.isNotEmpty
                          ? state.hadithEntity.length
                          : 1,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return state.hadithEntity.isEmpty
                            ? const Center(
                                child: Text(AppStrings.hadithNotFound),
                              )
                            : HadithCardWidget(
                                kPress: () => Navigator.of(context).pushNamed(
                                    Routes.hadithListenDetailsRoute,
                                    arguments: state.hadithEntity[index]),
                                hadithTitle: state.hadithEntity[index].id,
                                hadithSubTitle: state.hadithEntity[index].name);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text(AppStrings.hadithError,
                      style: TextStyle(fontSize: 30, color: AppColors.redDark)),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
