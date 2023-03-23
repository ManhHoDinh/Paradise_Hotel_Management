import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputWidget extends StatelessWidget {
  final String title;
  final String icon;

  const InputWidget({
    super.key, 
    required this.title, 
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                child: Image.asset(icon),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Text(title, 
                style: TextStyles.h6.setColor(ColorPalette.greyText)
                ,),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Image.asset(AssetHelper.icoLine),
          ),
        ],
      ),
    );
  }
}