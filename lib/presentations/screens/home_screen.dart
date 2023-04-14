import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/presentations/screens/CreateRoom_screen.dart';
import 'package:paradise/presentations/screens/RoomKindView.dart';
import 'package:paradise/presentations/screens/seeAll_screen.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/color_palatte.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../../core/models/firebase_request.dart';
import '../../core/models/room_model.dart';
import '../widgets/filter_containter_widget.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'home_screen';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPressed = false;
  int currentId = 0;
  int currentRoomId = 0;
  late List<RoomModel> listRoom;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

    Size size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 72) / 2;

    final double itemHeight = 180;
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Image.asset(AssetHelper.avatar),
          ),
          Container(
              margin: EdgeInsets.only(
                top: 30,
                bottom: 10,
              ),
              child: Text(
                'WHAT WOULD YOU DO?',
                style: TextStyles.h5.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primaryColor),
              )),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Hotel Information',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Book Room',
              color: ColorPalette.primaryColor,
              onTap: () {
                Navigator.of(context).pushNamed(CreateRoomScreen.routeName);
              },
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Kind Room',
              color: ColorPalette.primaryColor,
              onTap: () {
                Navigator.of(context).pushNamed(RoomKindView.routeName);
              },
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Staff',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Service',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Report',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: ButtonWidget(
              label: 'Receipt',
              color: ColorPalette.primaryColor,
              onTap: () {},
              textColor: ColorPalette.backgroundColor,
            ),
          ),
        ]),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.backgroundColor,
        leading: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            return _globalKey.currentState!.openDrawer();
          },
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
            StreamBuilder(
                stream: FireBaseDataBase.readRoomKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    RoomKindModel.kindItems.clear();
                    RoomKindModel.AllRoomKinds = snapshot.data!;
                    for (RoomKindModel k in RoomKindModel.AllRoomKinds) {
                      RoomKindModel.kindItems.add(k.Name ?? '');
                    }
                    print("Room Kind updated");
                  }
                  return Container();
                }),
            const SizedBox(height: 36),
            // Container(
            //   child: Container(
            //     child: SizedBox(
            //       height: 42,
            //       width: double.infinity,
            //       child: TextField(
            //         onChanged: (value) => valueSearch = value,
            //         decoration: InputDecoration(
            //             contentPadding: const EdgeInsets.only(top: 4),
            //             prefixIcon: InkWell(
            //               customBorder: CircleBorder(),
            //               onTap: () {},
            //               child: Icon(
            //                 FontAwesomeIcons.magnifyingGlass,
            //                 size: 16,
            //                 color: ColorPalette.greenText,
            //               ),
            //             ),
            //             suffixIcon: InkWell(
            //                 customBorder: CircleBorder(),
            //                 onTap: () {
            //                   setState(() {
            //                     isVisibleFilter = !isVisibleFilter;
            //                   });
            //                 },
            //                 child: Image.asset(AssetHelper.iconFilter)),
            //             hintText: 'Search',
            //             hintStyle: TextStyle(
            //               fontSize: 14,
            //               color: ColorPalette.grayText,
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(
            //                     color: ColorPalette.primaryColor, width: 2))),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 24),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     child: Visibility(
            //         visible: isVisibleFilter,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             FilterContainerWidget(
            //               name: 'name',
            //               icon1: Icon(
            //                 FontAwesomeIcons.arrowDown,
            //                 size: 12,
            //                 color: nameDecrease
            //                     ? ColorPalette.primaryColor
            //                     : ColorPalette.blackText,
            //               ),
            //               icon2: Icon(
            //                 FontAwesomeIcons.arrowUp,
            //                 size: 12,
            //                 color: nameDecrease
            //                     ? ColorPalette.blackText
            //                     : ColorPalette.primaryColor,
            //               ),
            //               onTapIconDown: () {
            //                 setState(() {
            //                   nameDecrease = true;
            //                 });
            //               },
            //               onTapIconUp: () {
            //                 setState(() {
            //                   nameDecrease = false;
            //                 });
            //               },
            //             ),
            //             FilterContainerWidget(
            //               name: 'price',
            //               icon1: Icon(
            //                 FontAwesomeIcons.arrowDown,
            //                 size: 12,
            //                 color: priceDecrease
            //                     ? ColorPalette.primaryColor
            //                     : ColorPalette.blackText,
            //               ),
            //               icon2: Icon(
            //                 FontAwesomeIcons.arrowUp,
            //                 size: 12,
            //                 color: priceDecrease
            //                     ? ColorPalette.blackText
            //                     : ColorPalette.primaryColor,
            //               ),
            //               onTapIconDown: () {
            //                 setState(() {
            //                   priceDecrease = true;
            //                 });
            //               },
            //               onTapIconUp: () {
            //                 setState(() {
            //                   priceDecrease = false;
            //                 });
            //               },
            //             ),
            //             Container(
            //               width: 100,
            //               height: 28,
            //               alignment: Alignment.center,
            //               decoration: BoxDecoration(
            //                   border: Border.all(color: ColorPalette.grayText),
            //                   borderRadius:
            //                       BorderRadius.circular(kMediumPadding)),
            //               child: DropdownButtonHideUnderline(
            //                 child: DropdownButton<String>(
            //                     value: dropdownValue,
            //                     items: items.map(buildMenuItem).toList(),
            //                     icon: Icon(FontAwesomeIcons.caretDown),
            //                     iconSize: 12,
            //                     hint: Text(
            //                       "Kind",
            //                       style: TextStyles.defaultStyle.grayText,
            //                     ),
            //                     iconEnabledColor: ColorPalette.primaryColor,
            //                     onChanged: (value) {
            //                       setState(() {
            //                         this.dropdownValue = value;
            //                       });
            //                     }),
            //               ),
            //             )
            //             // FilterContainerWidget(
            //             //   name: 'Kind',
            //             //   icon1: Icon(
            //             //     FontAwesomeIcons.caretDown,
            //             //     size: 12,
            //             //     color: ColorPalette.primaryColor,
            //             //   ),
            //             //   onTapIconDown: () {},

            //             //   // icon2: Icon(
            //             //   //   FontAwesomeIcons.arrowDown,
            //             //   //   size: 12,
            //             //   //   color: ColorPalette.blackText,
            //             //   // ),
            //             // )
            //           ],
            //         ))),
            Container(
              // padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Room',
                      style: TextStyles.defaultStyle.primaryTextColor.medium),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SeeAllScreen(listRoom: listRoom)));
                      },
                      child: Text('See all >', style: TextStyles.defaultStyle))
                ],
              ),
            ),
            Container(
              // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
              child: Expanded(
                child: StreamBuilder<List<RoomModel>>(
                    stream: FireBaseDataBase.readRooms(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        listRoom = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            // width / height: fixed for *all* items
                            childAspectRatio: 0.8,
                          ),
                          // return a custom ItemCard
                          itemBuilder: (context, i) => RoomItem(
                            room: listRoom[i],
                          ),
                          // RoomItem(

                          //     listRoom[i].PrimaryImage ?? AssetHelper.room1,
                          //     listRoom[i].name ?? '',
                          //     listRoom[i].type ?? '',
                          //     listRoom[i].
                          //     listRoom[i].price ?? 0),
                          itemCount: listRoom.length < 6 ? listRoom.length : 6,
                        );
                        // return GridView.count(
                        //   crossAxisCount: 2,
                        //   mainAxisSpacing: 24,
                        //   crossAxisSpacing: 24,
                        //   childAspectRatio: 0.8,

                        //   children: listRoom.map((e) {
                        //     return RoomItem(
                        //         e.PrimaryImage ?? AssetHelper.avatar,
                        //         e.name ?? '',
                        //         e.type ?? '',
                        //         e.price ?? 0);
                        //   }).toList(),
                        // );
                      } else
                        return Container();
                    }),
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
