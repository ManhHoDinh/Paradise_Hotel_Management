import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputWidget extends StatefulWidget {
  final String labelText;
  final String icon;
  final String? suffixIcon;
  final bool? isPassword;
  final TextInputType? type;
  final TextEditingController? controller;
  final String? Function(String? input)? validator;
  const InputWidget(
      {super.key,
      required this.labelText,
      required this.icon,
      this.suffixIcon,
      this.isPassword,
      this.controller,
      this.validator,
      this.type});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: isObscure,
      enableSuggestions: widget.isPassword ?? false,
      autocorrect: widget.isPassword ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Container(
          child: Image.asset(widget.icon),
          padding: const EdgeInsets.only(right: 16),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 24,
        ),
        suffixIcon: Container(
          child: widget.suffixIcon != null
            ? InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Image.asset(widget.suffixIcon!)
              )
            : Image.asset(widget.icon, opacity: const AlwaysStoppedAnimation(0),),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 24,
        ),
        label: Container(
          child: Text(
            widget.labelText,
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
