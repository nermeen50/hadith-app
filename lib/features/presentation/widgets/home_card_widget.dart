import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCardWidget extends StatelessWidget {
  final String cardLeadingImage;
  final String cardContent;
  final String cardTrailingImage;
  final List<Color> cardBackground;
  final VoidCallback? kPress;
  const HomeCardWidget(
      {Key? key,
      required this.cardLeadingImage,
      required this.cardContent,
      required this.cardTrailingImage,
      required this.cardBackground,
      this.kPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: kPress,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: cardBackground,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: SvgPicture.asset(cardLeadingImage),
            title: Text(cardContent),
            trailing: Image.asset(cardTrailingImage),
          ), //declare your widget here
        ),
      ),
    );
  }
}
