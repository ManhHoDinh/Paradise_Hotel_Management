import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final String icon;

  const InputWidget({
    super.key,
    required this.labelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      decoration: InputDecoration(
        prefixIcon: Image.asset(icon),
        prefixIconConstraints: BoxConstraints(
          minWidth: 24,
        ),
        label: Container(
          margin: const EdgeInsets.only(left: kItemPadding),
          child: Text(labelText,
            style: TextStyles.h6.setColor(ColorPalette.greyText),
          ),
        ),
      ),
      onSubmitted: (value) async {
        
      },
      onTapOutside: (event) {
        
      },
    );
  }
}