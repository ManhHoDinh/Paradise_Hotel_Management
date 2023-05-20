import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final String icon;
  final bool? isPassword;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? Function(String? input)? validator;
  const InputWidget(
      {super.key,
      required this.labelText,
      required this.icon,
      this.isPassword,
      this.controller,
      this.validator,
      this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      validator: validator,
      controller: controller,
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
      onTapOutside: (event) {},
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
