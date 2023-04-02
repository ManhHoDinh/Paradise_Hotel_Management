import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class ButtonDefault extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ButtonDefault({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        onTap: onTap,
        splashColor: Colors.amber,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration:
              BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: ColorPalette.primaryColor,
              ),
          padding: const EdgeInsets.symmetric(vertical: kMinPadding * 2),
          child: Text(
            label,
            style: TextStyles.h6.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}