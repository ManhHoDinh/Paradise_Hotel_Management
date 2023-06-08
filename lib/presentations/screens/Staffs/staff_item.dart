import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:paradise/presentations/screens/Staffs/edit_staff_screen.dart';
import 'package:paradise/presentations/screens/Staffs/staff_detail.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/text_styles.dart';

class StaffItem extends StatefulWidget {
  final UserModel userModel;
  const StaffItem({super.key, required this.userModel});

  @override
  State<StaffItem> createState() => _StaffItemState();
}

class _StaffItemState extends State<StaffItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StaffDetail(
                      userModel: widget.userModel,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorPalette.primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding, horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      child: Text(
                        widget.userModel.Name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: TextStyles.h6.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.darkBlueText),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditStaffScreen(
                                      userModel: widget.userModel,
                                    )));
                      },
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: ColorPalette.primaryColor,
                        size: 15,
                      ),
                    )
                  ]),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    // right: kDefaultPadding,
                    bottom: 12,
                  ),
                  child: Icon(
                    FontAwesomeIcons.idCard,
                    color: ColorPalette.primaryColor,
                    size: 13,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding - 5,
                    right: kDefaultPadding,
                    bottom: 12,
                  ),
                  child: Text(
                    widget.userModel.identification ?? '',
                    style: TextStyles.h6.copyWith(
                      color: ColorPalette.rankText,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    // right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Icon(
                    FontAwesomeIcons.phone,
                    color: ColorPalette.primaryColor,
                    size: 13,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding - 5,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: Container(
                    width: 100,
                    child: Text(
                      widget.userModel.PhoneNumber,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyles.h6.copyWith(
                        color: ColorPalette.rankText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding,
                    // right: kDefaultPadding,
                    bottom: 12,
                  ),
                  child: Icon(
                    FontAwesomeIcons.cakeCandles,
                    color: ColorPalette.primaryColor,
                    size: 13,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: kDefaultPadding - 5,
                    right: kDefaultPadding,
                    bottom: 12,
                  ),
                  child: Text(
                    widget.userModel.birthday ?? '',
                    style: TextStyles.h6.copyWith(
                      color: ColorPalette.rankText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
