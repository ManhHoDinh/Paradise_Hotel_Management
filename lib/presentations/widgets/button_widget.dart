import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  ButtonWidget({
    super.key, 
    required this.label, 
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: kDefaultBorderRadius,
      onTap: onTap,
      splashColor: Colors.amber,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          color: color
        ),
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Text(label,
          style: TextStyles.h6
                           .setColor(ColorPalette.blackText),
        ),
      ),
    );
  }
}