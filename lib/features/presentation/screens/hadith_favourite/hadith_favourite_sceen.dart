import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:hadith_app/features/presentation/widgets/tabbar_hadith_favourite.dart';

class HadithFavouriteScreen extends StatefulWidget {
  const HadithFavouriteScreen({Key? key}) : super(key: key);

  @override
  State<HadithFavouriteScreen> createState() => _HadithFavouriteScreenState();
}

class _HadithFavouriteScreenState extends State<HadithFavouriteScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(seconds: 1), () {
      BlocProvider.of<HadithCubit>(context).getFavouriteHadith();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<HadithCubit, HadithState>(buildWhen: (previous, current) {
        if (current is FavouriteHadithLoaded) {
          return true;
        } else {
          return false;
        }
      }, builder: (context, state) {
        if (state is FavouriteHadithLoaded) {
          BlocProvider.of<HadithCubit>(context)
              .initPlayerList(state.hadithEntity.length);

          return Stack(
            children: [
              SvgPicture.asset(AppAssets.homeBackground, fit: BoxFit.cover),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: SvgPicture.asset(AppAssets.arrowBack)),
                      title: SvgPicture.asset(AppAssets.appGreenLogo),
                    ),
                    const SizedBox(height: 20),
                    const Text(AppStrings.homeCartThree,
                        style: TextStyle(color: AppColors.primary)),
                    const SizedBox(height: 20),
                    TabbarHadithFavourite(
                        tabController: _tabController!,
                        tabarData: state.hadithEntity)
                  ],
                ),
              )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
