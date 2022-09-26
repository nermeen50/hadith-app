import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';
import 'package:hadith_app/core/utils/app_colors.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:share_plus/share_plus.dart';

class HadithDetailsScreen extends StatefulWidget {
  final HadithEntity hadithDetails;
  const HadithDetailsScreen({Key? key, required this.hadithDetails})
      : super(key: key);

  @override
  State<HadithDetailsScreen> createState() => _HadithDetailsScreenState();
}

class _HadithDetailsScreenState extends State<HadithDetailsScreen> {
  @override
  void initState() {
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
          Column(children: [
            ListTile(
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(AppAssets.arrowBack)),
                title: SvgPicture.asset(AppAssets.appGreenLogo)),
            ListTile(
              title: Text(widget.hadithDetails.id,
                  style: const TextStyle(color: AppColors.black)),
              subtitle: Text(widget.hadithDetails.name,
                  style: const TextStyle(color: AppColors.primary)),
              trailing: BlocBuilder<HadithCubit, HadithState>(
                  builder: (context, state) {
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
            ),
            const SizedBox(height: 30),
            Expanded(
                child: Container(
              alignment: AlignmentDirectional.topStart,
              color: AppColors.white,
              child: Text(widget.hadithDetails.text,
                  style: const TextStyle(color: AppColors.yellow)),
            )),
          ]),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Share.share(widget.hadithDetails.text,
                subject: widget.hadithDetails.text);
          },
          child: const Icon(Icons.share)),
    );
  }
}
