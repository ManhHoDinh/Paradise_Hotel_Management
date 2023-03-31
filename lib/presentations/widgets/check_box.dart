import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class CheckBoxWidget extends StatefulWidget {
  final String label;
  final Color color;

  const CheckBoxWidget({
    super.key, 
    required this.label,
    required this.color,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return widget.color;
    }
    return widget.color;
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return Transform.scale(
              scale: 0.7,
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateColor.resolveWith(
                    (states) => getColor(states)),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
              ),
            );
          }
        ),
        Container(
          padding: const EdgeInsets.only(left: 3),
          child: Text(widget.label,
            style: TextStyles.h6.light.copyWith(
              color: widget.color,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}