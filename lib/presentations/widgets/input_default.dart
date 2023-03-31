import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputDefault extends StatelessWidget {
  final String labelText;
  const InputDefault({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultIconSize * 2,
      child: TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 14, bottom: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              labelText,
              style: TextStyles.h6.copyWith(
                color: ColorPalette.grayText,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        onSubmitted: (value) async {},
        onTapOutside: (event) {},
      ),
    );
  }
}