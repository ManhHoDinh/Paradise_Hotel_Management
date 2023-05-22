import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';

class SettingScreen extends StatefulWidget {
  static final String routeName = 'setting_screen';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int currentId = 1;
  bool push_notifi1 = true;
  bool email1 = true;
  bool push_notifi2 = true;
  bool email2 = true;
  bool push_notifi3 = true;
  bool email3 = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('WELCOME',
                            style: TextStyle(
                                fontSize: 10, color: ColorPalette.grayText)),
                        Text(
                          'Vinpearl Hotel',
                          style: TextStyle(
                              fontSize: 16, color: ColorPalette.primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () {},
                      child: ImageHelper.loadFromAsset(AssetHelper.avatar,
                          height: 40),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy And Sharing',
              style: TextStyles.labelStaffDetail,
            ),
            SizedBox(height: 16),
            Text(
              "Manage your account data",
              style: TextStyles.labelStaffDetail
                  .copyWith(color: ColorPalette.darkBlueText, fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "You can make a request to download or delete your personal data from Travely.",
              style: TextStyles.staffInforDetail.copyWith(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                width: size.width - 96,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      width: size.width - 116,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request your personal data",
                            style: TextStyles.titleInfoDetail.copyWith(
                              color: ColorPalette.darkBlueText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "We'll create a file for you to download your personal data.",
                            style: TextStyles.desFunction,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        FontAwesomeIcons.greaterThan,
                        size: 12,
                        color: Color(0xff002270),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                width: size.width - 96,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      width: size.width - 116,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delete your account",
                            style: TextStyles.titleInfoDetail.copyWith(
                              color: ColorPalette.darkBlueText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "By doing this your account and data will permanently deleted.",
                            style: TextStyles.desFunction,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        FontAwesomeIcons.greaterThan,
                        size: 12,
                        color: Color(0xff002270),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 36.5),
            Text(
              'Notification',
              style: TextStyles.labelStaffDetail,
            ),
            SizedBox(height: 28),
            Text(
              'SPECIAL TIPS AND OFFERS',
              style: TextStyles.staffInforDetail.copyWith(fontSize: 10),
            ),
            Container(
              margin: EdgeInsets.only(top: 21.5),
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Push Notification',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: push_notifi1,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            push_notifi1 = value;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: email1,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            email1 = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 47),
            Text(
              'ACTIVITY',
              style: TextStyles.staffInforDetail.copyWith(fontSize: 10),
            ),
            Container(
              margin: EdgeInsets.only(top: 21.5),
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Push Notification',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: push_notifi2,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            push_notifi2 = value;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: email2,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            email2 = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 47),
            Text(
              'REMINDERS',
              style: TextStyles.staffInforDetail.copyWith(fontSize: 10),
            ),
            Container(
              margin: EdgeInsets.only(top: 21.5),
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Push Notification',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: push_notifi3,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            push_notifi3 = value;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyles.titleInfoDetail.copyWith(
                            color: ColorPalette.primaryColor.withOpacity(0.75)),
                      ),
                      Switch(
                        value: email3,
                        activeColor: ColorPalette.primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            email3 = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
