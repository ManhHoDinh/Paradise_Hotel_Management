import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class CheckBoxWidget extends StatefulWidget {
  final String label;
  final int value;
  final int groupValue;
  final void Function(bool?)? onChanged;

  const CheckBoxWidget({
    super.key, 
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  Color color = ColorPalette.grayText;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return color;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    color = widget.value == widget.groupValue
        ? ColorPalette.primaryColor
        : ColorPalette.grayText;

    return Row(
      children: [
        Container(
          width: kDefaultIconSize * 1,
          child: Transform.scale(
            alignment: Alignment.centerLeft,
            scale: 0.8,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateColor.resolveWith(
                  (states) => getColor(states)),
              value: widget.value == widget.groupValue,
              onChanged: widget.onChanged,
            ),
          ),
        ),
        AutoSizeText(widget.label,
        overflow: TextOverflow.fade,
          minFontSize: 6,
          style: TextStyles.h6.light.copyWith(
            color: ColorPalette.grayText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}