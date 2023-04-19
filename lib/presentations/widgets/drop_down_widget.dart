import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> kindItems;
  final String kindItem;

  const DropdownWidget({
    super.key,
    required this.kindItem,
    required this.kindItems,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String kindRoom;
  String? dropdownKindValue;

  DropdownMenuItem<String> buildMenuKindItem(String item) => DropdownMenuItem(
    value: item,
    onTap: () {
      setState(() {
        kindRoom = item;
      });
    },
    child: Text(
      item,
      style: TextStyles.h6.grayText.copyWith(
        fontStyle: FontStyle.italic
      ),
    )
  );

  @override
  Widget build(BuildContext context) {  
    kindRoom = widget.kindItem;
      
    return Container(
      height: kDefaultIconSize * 2,
      width: double.infinity,
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey),
          borderRadius:
              BorderRadius.circular(kMediumPadding)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          alignment: Alignment.centerLeft,
          iconStyleData: IconStyleData(
              iconEnabledColor:
                  ColorPalette.primaryColor),
          dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      kMinPadding))),
          hint: Text(
            kindRoom,
            style: TextStyles.h6.grayText.copyWith(
              fontStyle: FontStyle.italic
            ),
          ),
          items: widget.kindItems
              .map((e) => DropdownMenuItem<String>(
                  value: e,
                  onTap: () {
                    setState(() {
                      kindRoom = e;
                    });
                  },
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles
                        .h6.grayText
                        .copyWith(fontStyle: FontStyle.italic),
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
          value: dropdownKindValue,
          onChanged: (value) {
            setState(() {
              dropdownKindValue = value;
            });
          },
        ),
      ));
  }
}