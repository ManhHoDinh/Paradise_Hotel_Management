import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final String icon;
  final bool? isPassword;
  const InputWidget({
    super.key,
    required this.labelText,
    required this.icon,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      obscureText: isPassword ?? false,
      enableSuggestions: isPassword ?? false,
      autocorrect: isPassword ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Container(
          child: Image.asset(icon),
          padding: const EdgeInsets.only(right: 16),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 24,
        ),
        label: Container(
          child: Text(
            labelText,
            style: TextStyles.h6.setColor(ColorPalette.grayText),
          ),
        ),
      ),
      onSubmitted: (value) async {},
      onTapOutside: (event) {},
    );
  }
}
