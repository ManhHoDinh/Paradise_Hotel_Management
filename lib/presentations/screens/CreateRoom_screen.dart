import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/check_box.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:paradise/presentations/widgets/input_default.dart';
import 'package:paradise/presentations/widgets/upload_button.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = 'CreateRoom_screen';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  int currentId = 0, _value = 1;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorPalette.primaryColor,
          leadingWidth: kDefaultIconSize * 3,
          leading: Container(
            width: double.infinity,
            child: InkWell(
              customBorder: CircleBorder(),
              onHighlightChanged: (param) {
              },
              splashColor: ColorPalette.primaryColor,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Image.asset(AssetHelper.icoLeftArrow,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          title: Container(
            child: Text('ROOMS',
              style: TextStyles.slo.bold.copyWith(
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: Offset(3, 6),
                    blurRadius: 6,
                  )
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        endDrawer: Drawer(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kMaxPadding),
                  child: Text('ROOM OPTIONS',
                    style: TextStyles.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.primaryColor
                    ),
                  ),
                ),
                Container(margin: const EdgeInsets.symmetric(vertical: kDefaultPadding), 
                  child: ButtonDefault(label: 'Book Room', onTap: () {})),
                Container(margin: const EdgeInsets.symmetric(vertical: kDefaultPadding), 
                  child: ButtonDefault(label: 'Create New Room', onTap: () {})),
                Container(margin: const EdgeInsets.symmetric(vertical: kDefaultPadding), 
                  child: ButtonDefault(label: 'Edit Room', onTap: () {})),
              ],
            ),
          ),
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
              StatefulBuilder(
                  builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: kMaxPadding * 1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckBoxWidget(label: '150.000',
                          value: 1,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = 1;
                            });
                          },
                        ),
                        CheckBoxWidget(label: '170.000',
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = 2;
                            });
                          },
                        ),
                        CheckBoxWidget(label: '200.000',
                          value: 3,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = 3;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
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
                margin: const EdgeInsets.symmetric(vertical: kMediumPadding * 1.5, horizontal: kMaxPadding * 3),
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
        // bottomNavigationBar: SalomonBottomBar(
        //   currentIndex: currentId,
        //   onTap: (id) {
        //     setState(() {
        //       currentId = id;
        //     });
        //   },
        //   items: [
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.house,
        //         size: 20,
        //       ),
        //       title: Text('Home')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.gear,
        //         size: 20,
        //       ),
        //       title: Text('Setting')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.bell,
        //         size: 20,
        //       ),
        //       title: Text('Notification')
        //     ),
        //     SalomonBottomBarItem(
        //       icon: Icon(
        //         FontAwesomeIcons.user,
        //         size: 20,
        //       ),
        //       title: Text('Account')
        //     ),
        //   ]
        // ),
      ),
      onTap:() {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}