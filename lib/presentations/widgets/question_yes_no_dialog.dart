import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class QuestionYesNoDialog extends StatelessWidget {
  final String task;
  var icon = FontAwesomeIcons.trashCan;
  VoidCallback? yesOnTap;
  VoidCallback? noOnTap;

  QuestionYesNoDialog(
      {super.key,
      required this.task,
      required this.icon,
      required this.yesOnTap,
      required this.noOnTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        // icon: Image.asset(
        //   icon,
        //   excludeFromSemantics: true,
        //   height: 120,
        // ),

        icon: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: ColorPalette.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(3604))),
            child: Icon(
              icon,
              size: 50,
              color: Color(0xffE45826),
            ),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
        actions: [
          ChoseButton(
              onTap: yesOnTap, title: 'Yes', color: ColorPalette.primaryColor),
          ChoseButton(
              onTap: noOnTap, title: 'No', color: ColorPalette.redColor),
        ],
        content: Text(
          'Do you sure ' + task + ' room?',
          textAlign: TextAlign.center,
          style: TextStyles.h5.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget ChoseButton({onTap, title, color}) {
    return TextButton(
        onPressed: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 38,
          decoration: BoxDecoration(
              color: color ?? ColorPalette.redColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            title ?? '',
            style: TextStyles.h6.copyWith(color: ColorPalette.backgroundColor),
          ),
        ));
  }
}
