import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:paradise/core/constants/color_palatte.dart';

import '../../core/constants/dimension_constants.dart';
import '../../core/helpers/text_styles.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, this.title, this.selected, this.Items});
  List<String>? Items = [];
  String? selected = '';
  String? title = '';
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: Alignment.centerLeft,
        iconStyleData:
            IconStyleData(iconEnabledColor: ColorPalette.primaryColor),
        dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kMinPadding))),
        hint: Text(
          widget.title ?? '',
          style: TextStyles.defaultStyle.grayText,
        ),
        items: widget.Items!
            .map((e) => DropdownMenuItem<String>(
                value: e,
                onTap: () {
                  setState(() {
                    widget.selected = e;
                  });
                },
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyles.defaultStyle.grayText.copyWith(fontSize: 13),
                )))
            .toList(),
        buttonStyleData: const ButtonStyleData(
          padding: const EdgeInsets.only(left: 12),
          height: 28,
          width: 150,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 28,
        ),
        value: widget.selected,
        onChanged: (value) {
          setState(() {
            widget.selected = value;
          });
        },
      ),
    );
  }
}
