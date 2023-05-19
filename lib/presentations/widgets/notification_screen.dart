import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/presentations/widgets/setting_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../../core/helpers/text_styles.dart';
import '../screens/Onboardings/home_screen.dart';

class NotificationScreen extends StatefulWidget {
  static final String routeName = 'notification_screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentId = 2;
  List<String> abc = ["7:30 - 09/05/2023"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 190),
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
        padding: EdgeInsets.all(31),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: ColorPalette.primaryColor.withOpacity(0.75),
                      width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Being Late",
                    style: TextStyles.titlenotifi,
                  ),
                  SizedBox(height: 15),
                  Text(
                    abc[0],
                    style: TextStyles.timenotifi,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentId,
          onTap: (id) {
            setState(() {
              currentId = id;
            });
            if (id == 0) {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            }
            if (id == 1) {
              Navigator.of(context).pushNamed(SettingScreen.routeName);
            }
            if (id == 2) {
              Navigator.of(context).pushNamed(NotificationScreen.routeName);
            }
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                color: ColorPalette.primaryColor,
                size: 20,
              ),
              title: Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.gear,
                color: ColorPalette.primaryColor,
                size: 20,
              ),
              title: Text('Setting'),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.bell,
                color: ColorPalette.primaryColor,
                size: 20,
              ),
              title: Text('Notification'),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                color: ColorPalette.primaryColor,
                size: 20,
              ),
              title: Text('Account'),
            ),
          ]),
    );
  }
}
