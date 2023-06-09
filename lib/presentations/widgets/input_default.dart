import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class InputDefault extends StatefulWidget {
  String labelText;
  TextEditingController? controller = new TextEditingController();
  InputDefault({
    super.key,
    required this.labelText,
    this.controller,
  });
  @override
  State<InputDefault> createState() => _InputDefaultState();
}

class _InputDefaultState extends State<InputDefault> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kDefaultIconSize * 2,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 14, right: 14, bottom: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              widget.labelText,
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
