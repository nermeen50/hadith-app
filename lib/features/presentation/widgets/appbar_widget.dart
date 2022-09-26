import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadith_app/core/utils/app_assets.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const CustomAppBarWidget({
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppAssets.arrowBack)),
      title: SvgPicture.asset(AppAssets.appGreenLogo),
    );
  }
}
