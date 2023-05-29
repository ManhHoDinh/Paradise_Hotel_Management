import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/guest_kind_model.dart';

import '../screens/GuestKinds/EditGuestKindScreen.dart';

class GuestKindWidget extends StatelessWidget {
  GuestKindWidget({super.key, this.GuestKind});
  GuestKindModel? GuestKind;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 25),
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Color(0xffE5E5E5), width: 1)),
      child: Column(children: [
        Expanded(
          child: Row(
            children: [
              Text(
                GuestKind!.Name ?? '',
                style: TextStyles.h3.copyWith(color: ColorPalette.primaryColor),
              ),
              Spacer(),
              AuthServices.CurrentUserIsManager()
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditGuestKindScreen(
                                      guestKind: GuestKind,
                                    )));
                      },
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: ColorPalette.primaryColor,
                        size: 15,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                'ID:',
                style: TextStyles.h6.copyWith(color: ColorPalette.grayText),
              ),
              SizedBox(
                width: 72,
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                width: 115,
                child: Text(
                  GuestKind!.GuestKindID ?? '',
                  style:
                      TextStyles.h6.copyWith(color: ColorPalette.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                'R.O.S:',
                style: TextStyles.h6.copyWith(color: ColorPalette.grayText),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                GuestKind!.ratio.toString() ?? '',
                style: TextStyles.h6.copyWith(color: ColorPalette.primaryColor),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
