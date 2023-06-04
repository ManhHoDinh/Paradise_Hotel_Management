import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/user_model.dart';
import 'package:paradise/presentations/screens/Bookings/all_rental_form.dart';
import 'package:paradise/presentations/screens/GuestKinds/GuestKindView.dart';
import 'package:paradise/presentations/screens/Receipts/SeeAllReceipt.dart';
import 'package:paradise/presentations/screens/RoomKinds/RoomKindView.dart';
import 'package:paradise/presentations/screens/Rooms/seeAll_screen.dart';
import 'package:paradise/presentations/screens/Staffs/staff_detail.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/helpers/AuthFunctions.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../core/models/firebase_request.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../../core/models/guest_model.dart';
import '../../../core/models/room_model.dart';
import '../Staffs/staff_screen.dart';
import '../report_screen.dart';
import 'login_screen.dart';

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
  String? currentUserID;
  late List<RoomModel> listRoom;
  @override
  void initState() {
    setCurrentUserId();
    // TODO: implement initState
    super.initState();
  }

  void setCurrentUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    currentUserID = pref.getString('currentUser');
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    String position = '';

    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  child: ImageHelper.loadFromAsset(AssetHelper.avatar,
                      width: 110, height: 110)),
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
                  label: 'Guest Kind',
                  color: ColorPalette.primaryColor,
                  onTap: () {
                    Navigator.of(context).pushNamed(GuestKindView.routeName);
                  },
                  textColor: ColorPalette.backgroundColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                child: ButtonWidget(
                  label: 'Room Kind',
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
                  label: 'Rental Form',
                  color: ColorPalette.primaryColor,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AllRentalForm()));
                  },
                  textColor: ColorPalette.backgroundColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                child: ButtonWidget(
                  label: 'Receipt',
                  color: ColorPalette.primaryColor,
                  onTap: () {
                    Navigator.of(context).pushNamed(SeeAllReceipts.routeName);
                  },
                  textColor: ColorPalette.backgroundColor,
                ),
              ),
              AuthServices.CurrentUserIsManager()
                  ? Container(
                      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: ButtonWidget(
                        label: 'Report',
                        color: ColorPalette.primaryColor,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ReportScreen.routeName);
                        },
                        textColor: ColorPalette.backgroundColor,
                      ),
                    )
                  : Container(),
              AuthServices.CurrentUserIsManager()
                  ? Container(
                      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: ButtonWidget(
                        label: 'Users Management',
                        color: ColorPalette.primaryColor,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ReportScreen.routeName);
                        },
                        textColor: ColorPalette.backgroundColor,
                      ),
                    )
                  : Container(),
              // StreamBuilder(
              //     stream: FireBaseDataBase.readUsers(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         List<UserModel> listUser = snapshot.data!;
              //         for (UserModel user in listUser) {
              //           if (user.id == currentUserID) {
              //             UserModel.currentUser = user;
              //           }
              //         }
              //       }
              //       if (UserModel.currentUser.position == "Manager") {
              //         return Container(
              //           padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              //           child: ButtonWidget(
              //             label: 'Staff',
              //             color: ColorPalette.primaryColor,
              //             onTap: () {
              //               Navigator.of(context)
              //                   .pushNamed(StaffScreen.routeName);
              //             },
              //             textColor: ColorPalette.backgroundColor,
              //           ),
              //         );
              //       } else
              //         return Container();
              //     }),
            ]),
          ),
        ),
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
                  }
                  return Container();
                }),
            StreamBuilder(
                stream: FireBaseDataBase.readGuestKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    GuestKindModel.AllGuestKinds = snapshot.data!;
                  }
                  return Container();
                }),
            StreamBuilder(
                stream: FireBaseDataBase.readGuests(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    GuestModel.AllGuests = snapshot.data!;
                  }
                  return Container();
                }),
            InkWell(
              child: Text('f'),
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(UserModel.currentUser.getUserId())));

                FirebaseAuth.instance.signOut();
              },
            ),
            const SizedBox(height: 36),
            Container(
              // padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Room',
                      style: TextStyles.defaultStyle.primaryTextColor.medium),
                  TextButton(
                      onPressed: () async {
                        // SharedPreferences pref =
                        //     await SharedPreferences.getInstance();
                        // pref.remove('email');
                        Navigator.of(context)
                            .pushNamed(SeeAllRoomsScreen.routeName);
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
                        RoomModel.AllRooms = snapshot.data!;
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
    );
  }
}
