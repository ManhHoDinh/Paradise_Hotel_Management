import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';

class RoomItem extends StatefulWidget {
  final String image;
  final String roomID;
  final String type;
  final int cost;
  final String status;
  const RoomItem(
      {super.key,
      required this.image,
      required this.roomID,
      required this.type,
      required this.cost,
      required this.status});

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  @override
  Widget build(BuildContext context) {
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
              ImageHelper.loadFromNetwork(
                widget.image,
                width: double.maxFinite,
                height: 105,
                fit: BoxFit.fitWidth,
                radius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.status == 'Booked'
                            ? Colors.red.withOpacity(0.8)
                            : Colors.orange.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMinPadding * 1.5))),
                    height: 20,
                    width: 55,
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.status}',
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
                    widget.roomID,
                    style: TextStyles.defaultStyle.DarkPrimaryTextColor.medium,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(AssetHelper.iconTypeRoom),
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(widget.type,
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
                    child: Text('\$ ${widget.cost} VNĐ',
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
