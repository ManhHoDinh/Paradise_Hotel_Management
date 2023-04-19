import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/src/rendering/box.dart';

class RoomDetailScreen extends StatefulWidget {
  static final String routeName = 'room_detail';
  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  bool isPressed = false;
  String _room_id = 'P001';
  int currentId = 0;
  int _currenImage = 0;
  PageController _pageController = PageController();
  Image abc = Image.asset(AssetHelper.roomDetail1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 219,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _currenImage = value;
                        });
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          abc = Image.asset(AssetHelper.roomDetail1);
                        }
                        if (index == 1) {
                          abc = Image.asset(AssetHelper.roomDetail2);
                        }
                        if (index == 2) {
                          abc = Image.asset(AssetHelper.roomDetail3);
                        }
                        if (index == 3) {
                          abc = Image.asset(AssetHelper.roomDetail4);
                        }
                        return Container(
                          height: 219,
                          child: abc,
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 150,
                          padding: EdgeInsets.only(left: 42, right: 42),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: isPressed
                                      ? ColorPalette.primaryColor
                                      : ColorPalette.backgroundColor,
                                ),
                              ),
                              Text(_room_id,
                                  style: TextStyles.h9.copyWith(
                                    letterSpacing: 3.05,
                                    color: ColorPalette.backgroundColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  )),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.list,
                                  color: isPressed
                                      ? ColorPalette.primaryColor
                                      : ColorPalette.backgroundColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width / 3 + 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: size.width / 3 - 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return imageIndicator(
                                        index == _currenImage);
                                  },
                                ),
                              ),
                              Container(
                                width: size.width / 3 + 20,
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 55,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10)),
                                    color: Color(0xffF0A500).withOpacity(0.8),
                                  ),
                                  child: Text(
                                    'Booked',
                                    style: TextStyles.calendarNote.copyWith(
                                      fontSize: 10,
                                      color: ColorPalette.backgroundColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xff12276).withOpacity(0.05),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: [
                          Text(
                            '$_room_id - TYPE1',
                            style: TextStyles.labelStaffDetail.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(AssetHelper.iconEdit),
                            ),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff12276).withOpacity(0.05),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(AssetHelper.iconMoney),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '150.000VND',
                                      style: TextStyles.inforRoomDetail,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'PER NIGHT',
                                      style:
                                          TextStyles.inforRoomDetail.copyWith(
                                        color: ColorPalette.rankText,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(AssetHelper.iconCircleUser),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3 PEOPLE',
                                      style: TextStyles.inforRoomDetail,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'MAX CAPACITY',
                                      style:
                                          TextStyles.inforRoomDetail.copyWith(
                                        color: ColorPalette.rankText,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'PHOTOS',
                          style: TextStyles.inforRoomDetail.copyWith(
                            color: ColorPalette.rankText,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (size.width - 125) / 3,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.roomDetail2)),
                            ),
                          ),
                          Container(
                            width: (size.width - 125) / 3,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.roomDetail3)),
                            ),
                          ),
                          Container(
                            width: (size.width - 125) / 3,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: const Image(
                                  image: AssetImage(AssetHelper.roomDetail4)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width - 80,
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xff12276).withOpacity(0.05),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Description',
                            style: TextStyles.h9.copyWith(
                              color: ColorPalette.darkBlueText,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Ramayana Prambanan is a show that combines dance and drama without dialogue, based on the Ramayana story, it\'s performed near Prambanan Temple on Java Island, Indonesia. Ramayana Prambanan performs since 1961.',
                            style: TextStyles.descriptionRoom,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: size.width - 80,
                      padding: EdgeInsets.only(
                          top: 16, left: 30, right: 30, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE6F6F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  Text(
                                    'P',
                                    style: TextStyle(
                                      color: ColorPalette.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Parking',
                                style: TextStyles.iconInDetailRoom.copyWith(
                                    color: Color(0xff000000).withOpacity(0.5)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE6F6F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.wifi,
                                    size: 19,
                                    color: ColorPalette.primaryColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Wi-fi',
                                style: TextStyles.iconInDetailRoom.copyWith(
                                    color: Color(0xff000000).withOpacity(0.5)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE6F6F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.cutlery,
                                    size: 20,
                                    color: ColorPalette.primaryColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Resto',
                                style: TextStyles.iconInDetailRoom.copyWith(
                                    color: Color(0xff000000).withOpacity(0.5)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE6F6F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.restroom,
                                    size: 20,
                                    color: ColorPalette.primaryColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'WC',
                                style: TextStyles.iconInDetailRoom.copyWith(
                                    color: Color(0xff000000).withOpacity(0.5)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
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
      ),
    );
  }

  Widget imageIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Icon(
        FontAwesomeIcons.solidCircle,
        size: 9,
        color: isActive ? Color(0xffE5E5E5) : ColorPalette.detailBorder,
      ),
    );
  }
}
