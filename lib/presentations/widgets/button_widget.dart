import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
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
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: onTap,
      splashColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: color
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32 * 4, vertical: 16),
        child: Text(label,
          style: TextStyles.h6
                           .setColor(ColorPalette.blackText),
        ),
      ),
    );
  }
}