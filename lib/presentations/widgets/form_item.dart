import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_model.dart';

import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../../core/models/rental_form_model.dart';

class FormItem extends StatefulWidget {
  FormItem({super.key, required this.form});
  RentalFormModel form;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  var numberToMonthMap = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RentalFormModel formModel = widget.form;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorPalette.grayText),
        ),
        child: Column(children: [
          Stack(
            children: [
              RoomModel.getRoomImageByID(formModel.RoomID).length != 0
                  ? ImageHelper.loadFromNetwork(
                      RoomModel.getRoomImageByID(formModel.RoomID),
                      width: double.maxFinite,
                      height: 105,
                      fit: BoxFit.fill,
                      radius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    )
                  : ImageHelper.loadFromAsset(
                      AssetHelper.roomDetail1,
                      width: double.maxFinite,
                      height: 105,
                      fit: BoxFit.fill,
                      radius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: formModel.Status == 'Unpaid'
                          ? Color(0xffF0A500).withOpacity(0.44)
                          : ColorPalette.greenText.withOpacity(0.7),
                    ),
                    height: 20,
                    width: 55,
                    alignment: Alignment.center,
                    child: Text(
                      '${formModel.Status}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    formModel.RentalID,
                    maxLines: 1,
                    style: TextStyles.defaultStyle.DarkPrimaryTextColor.medium,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(AssetHelper.iconTypeRoom),
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(formModel.RoomID,
                          style: TextStyles.subTextStyle.light),
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
                    child: Text(
                        '${formModel.beginDate.day} ${numberToMonthMap[formModel.beginDate.month]}',
                        maxLines: 1,
                        style: TextStyles
                            .defaultStyle.DarkPrimaryTextColor.medium))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
