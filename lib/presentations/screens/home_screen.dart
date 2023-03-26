import 'dart:developer';
import 'package:paradise/presentations/screens/splash_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/color_palatte.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../../core/models/room_model.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'home_screen';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPressed = false;
  int currentId = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;

    final double itemHeight = 180;
    List<RoomModel> listRoom = [
      RoomModel(AssetHelper.room1, 'Room 1', 'Family Room', 200000),
      RoomModel(AssetHelper.room2, 'Room 2', 'Master Room', 170000),
      RoomModel(AssetHelper.room3, 'Room 3', 'Couple Room', 150000),
      RoomModel(AssetHelper.room4, 'Room 4', 'Couple Room', 150000),
      RoomModel(AssetHelper.room5, 'Room 5', 'Family Room', 200000),
      RoomModel(AssetHelper.room6, 'Room 6', 'Master Room', 170000),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        leading: InkWell(
          customBorder: CircleBorder(),
          onHighlightChanged: (param) {
            setState(() {
              isPressed = param;
            });
          },
          onTap: () {},
          child: Container(
            child: Icon(
              FontAwesomeIcons.bars,
              color: isPressed
                  ? ColorPalette.greenText
                  : ColorPalette.primaryColor,
            ),
          ),
        ),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Container(
              child: Container(
                child: SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 4),
                        prefixIcon: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 16,
                            color: ColorPalette.greenText,
                          ),
                        ),
                        suffixIcon: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {},
                            child: Image.asset(AssetHelper.iconFilter)),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: ColorPalette.grayText,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.primaryColor, width: 2))),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Room',
                      style: TextStyles.defaultStyle.primaryTextColor.medium),
                  TextButton(
                      onPressed: () {},
                      child: Text('See all >', style: TextStyles.defaultStyle))
                ],
              ),
            ),
            Container(
              // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
              child: Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 0.8,
                  children: listRoom
                      .map((e) => RoomItem(e.image!, e.name!, e.type!, e.cost!))
                      .toList(),
                ),
              ),
            )
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
                title: Text('Home')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.gear,
                  size: 20,
                ),
                title: Text('Setting')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  size: 20,
                ),
                title: Text('Notification')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: 20,
                ),
                title: Text('Account')),
          ]),
    );
  }
}
