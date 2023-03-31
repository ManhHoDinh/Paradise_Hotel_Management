import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';

import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';

Widget RoomItem(String image, String name, String type, int cost) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: ColorPalette.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorPalette.grayText),
      ),
      child: Column(children: [
        ImageHelper.loadFromAsset(
          image,
          width: double.maxFinite,
          radius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  name,
                  style: TextStyles.defaultStyle.DarkPrimaryTextColor.medium,
                ),
              ),
              Row(
                children: [
                  Image.asset(AssetHelper.icoTypeRoom),
                  Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(type, style: TextStyles.subTextStyle.light),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 1,
                width: double.infinity,
                color: ColorPalette.blackText,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text('\$ $cost VNĐ',
                      style:
                          TextStyles.defaultStyle.DarkPrimaryTextColor.medium))
            ],
          ),
        )
      ]),
    ),
  );
}
