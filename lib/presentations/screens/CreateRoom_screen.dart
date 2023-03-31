import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/check_box.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = 'CreateRoom_screen';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  int currentId = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leadingWidth: kMaxPadding * 2,
        leading: Container(
          padding: const EdgeInsets.only(right: kDefaultPadding, top: kItemPadding),
          child: Drawer(
            backgroundColor: ColorPalette.primaryColor,
            elevation: 0,
            child: Image.asset(AssetHelper.icoLeftArrow),
          ),
        ),
        title: Container(
          child: Text('ROOMS',
            style: TextStyles.slo.bold,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 6),
                blurRadius: 9
              )
            ]
          ),
        ),
        toolbarHeight: kToolbarHeight * 1.5,
        actions: [
          InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {
              setState(() {
                isPressed = param;
              });
            },
            splashColor: ColorPalette.primaryColor,
            onTap: () {
              print('object');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              child: Icon(
                FontAwesomeIcons.bars,
                color: isPressed
                    ? ColorPalette.greenText
                    : ColorPalette.backgroundColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
              child: Text('CREATE NEW ROOM',
                style: TextStyles.h4.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
              child: Text('Room ID',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              child: InputDefault(labelText: 'Type here'),
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
            ),
            Container(
              child: Text('Name of room',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              child: InputDefault(labelText: 'Type here'),
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
            ),
            Container(
              child: Text('Type of room',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              child: InputDefault(labelText: 'Type here'),
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
            ),
            Container(
              child: Text('Price',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding + 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: CheckBoxWidget(
                      label: '150.000',
                      color: ColorPalette.grayText,
                    ),
                  ),
                  Container(
                    child: CheckBoxWidget(
                      label: '170.000',
                      color: ColorPalette.grayText,
                    ),),
                  Container(
                    child: CheckBoxWidget(
                      label: '200.000',
                      color: ColorPalette.grayText,
                    ),),
                ],
              ),
            ),
            Container(
              child: Text('Note',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              child: InputDefault(labelText: 'Type here'),
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
            ),
            Container(
              child: Text('Pictures',
                style: TextStyles.h6.copyWith(
                  color: ColorPalette.darkBlueText
                ),
              ),
              margin: const EdgeInsets.only(left: kMaxPadding * 1.5),
            ),
            Container(
              // padding: const EdgeInsets.only(top: 200),
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
              child: UploadButton(label: 'Upload here', 
                icon: AssetHelper.icoUpload,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: kMediumPadding * 1.5),
              child: ButtonDefault(
                label: 'Create',
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return DialogOverlay(isSuccess: true,);
                  });
                },
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
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 20,
            ),
            title: Text('Home')
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.gear,
              size: 20,
            ),
            title: Text('Setting')
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.bell,
              size: 20,
            ),
            title: Text('Notification')
          ),
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.user,
              size: 20,
            ),
            title: Text('Account')
          ),
        ]
      ),
    );
  }
}