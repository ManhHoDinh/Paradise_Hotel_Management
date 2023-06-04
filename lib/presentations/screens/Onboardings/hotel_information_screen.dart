import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/AuthFunctions.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';
import '../../../core/models/room_kind_model.dart';
import '../../../core/models/room_model.dart';
import '../../widgets/filter_containter_widget.dart';
import '../Rooms/CreateRoom_screen.dart';

class HotelInforScreen extends StatefulWidget {
  static final String routeName = 'hotel_infor_screen';
  const HotelInforScreen({super.key});

  @override
  State<HotelInforScreen> createState() => _HotelInforScreenState();
}

class _HotelInforScreenState extends State<HotelInforScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leadingWidth: kDefaultIconSize * 3,
        leading: Container(
          width: double.infinity,
          child: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {},
            splashColor: ColorPalette.primaryColor,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(FontAwesomeIcons.arrowLeft),
            ),
          ),
        ),
        title: Container(
          child: Text(
            'VINPEARL HOTEL',
            style: TextStyles.h8.bold.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(3, 6),
                  blurRadius: 6,
                )
              ],
              letterSpacing: 1.175,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Photos',
                style: TextStyles.titlehotelinfor,
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.angleDoubleLeft,
                          size: 15,
                          color: ColorPalette.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child:
                          Image.asset(AssetHelper.inforhotel, fit: BoxFit.fill),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.angleDoubleRight,
                          size: 15,
                          color: ColorPalette.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'About',
                style: TextStyles.titlehotelinfor,
              ),
              SizedBox(height: 19),
              Text(
                "This sprawling beachfront resort on the East Vietnam Sea coast lies 42 km from Da Nang International Airport and 13 km from the city of Hội An, a UNESCO World Heritage Site.\n\nPolished rooms feature free Wi-Fi and minibars, as well as flat-screen TVs and balconies offering views of the pool and/or gardens. Upgraded rooms have sea views. Suites and 2- and 3-bedroom villas add separate living areas.\n\nBreakfast and an airport shuttle are complimentary. Other amenities include 3 restaurants and 2 bars, plus an 18-hole golf course, a wildlife park and beach access. There's also an amusement park, an outdoor pool & a gym, plus a spa and a kids' club.",
                style: TextStyles.inforRoomDetail.copyWith(
                  color: ColorPalette.detailBorder.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Address & contact information',
                style: TextStyles.titlehotelinfor,
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.mapLocationDot,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  Text(
                    "Bình Minh, Thăng Bình District, Quảng Nam",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.phone,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "0235 3676 888",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Health and safety',
                style: TextStyles.titlehotelinfor,
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.circlePlus,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Enhanced cleaning",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.handHoldingHeart,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Personal protection",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.route,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Physical distancing",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.shieldVirus,
                    size: 20,
                    color: ColorPalette.primaryColor.withOpacity(0.5),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Increased food safety",
                    style: TextStyles.inforRoomDetail.copyWith(
                      color: ColorPalette.detailBorder.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Amenities',
                style: TextStyles.titlehotelinfor,
              ),
              SizedBox(height: 19),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.swimmingPool,
                          size: 20,
                          color: ColorPalette.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Pool",
                          style: TextStyles.inforRoomDetail.copyWith(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.plateWheat,
                          size: 20,
                          color: ColorPalette.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Breakfast",
                          style: TextStyles.inforRoomDetail.copyWith(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.spa,
                          size: 20,
                          color: ColorPalette.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Spa",
                          style: TextStyles.inforRoomDetail.copyWith(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.wifi,
                          size: 20,
                          color: ColorPalette.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Wifi",
                          style: TextStyles.inforRoomDetail.copyWith(
                            color: ColorPalette.detailBorder.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (id) {
            setState(() {
              _currentIndex = id;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                  color: ColorPalette.primaryColor,
                  size: 20,
                ),
                title: Text('Home')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.gear,
                  color: ColorPalette.primaryColor,
                  size: 20,
                ),
                title: Text('Setting')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  color: ColorPalette.primaryColor,
                  size: 20,
                ),
                title: Text('Notification')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  color: ColorPalette.primaryColor,
                  size: 20,
                ),
                title: Text('Account')),
          ]),
    );
  }
}
