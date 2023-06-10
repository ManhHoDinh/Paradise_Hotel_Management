import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/Rooms/CreateRoom_screen.dart';
import 'package:paradise/presentations/widgets/filter_containter_widget.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/helpers/AuthFunctions.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../widgets/button_default.dart';

class SeeAllRoomsScreen extends StatefulWidget {
  static final String routeName = 'see_all_room_screen';

  SeeAllRoomsScreen({super.key});

  @override
  State<SeeAllRoomsScreen> createState() => _SeeAllRoomsScreenState();
}

class _SeeAllRoomsScreenState extends State<SeeAllRoomsScreen> {
  late List<RoomModel> listRoom;
  bool isVisibleFilter = false;
  bool priceDecrease = false;
  String? kindRoom;
  String? status;
  String? valueSearch;
  String? dropdownKindValue;
  String? dropdownStatusValue;
  List<String> kindItems = ['All'];
  final statusItems = ['All', 'Booked', 'Available'];
  DropdownMenuItem<String> buildMenuKindItem(String item) => DropdownMenuItem(
      value: item,
      onTap: () {
        setState(() {
          kindRoom = item;
        });
      },
      child: Text(
        item,
        style: TextStyles.defaultStyle.grayText,
      ));
  DropdownMenuItem<String> buildMenuStatusItem(String item) => DropdownMenuItem(
      value: item,
      onTap: () {
        setState(() {
          status = item;
        });
      },
      child: Text(
        item,
        style: TextStyles.defaultStyle.grayText,
      ));
  List<RoomModel> loadListRoom(List<RoomModel> list) {
    if (priceDecrease) {
      list.sort((a, b) => b.getPrice().compareTo(a.getPrice()));
    } else {
      list.sort((a, b) => a.getPrice().compareTo(b.getPrice()));
    }
    List<RoomModel> newList = List.from(list);
    switch (status) {
      case "All":
        newList = newList;
        break;
      case "Booked":
        newList = newList.where((room) => room.State! == 'Booked').toList();
        break;
      case "Available":
        newList = newList.where((room) => room.State! == 'Available').toList();
        break;
      default:
        newList = newList;
    }
    if (kindRoom == 'All') {
      newList = newList;
    } else if (kindRoom != null) {
      newList = newList
          .where((room) =>
              RoomKindModel.getRoomKindName(room.RoomKindID ?? '') == kindRoom)
          .toList();
    }
    if (valueSearch != null) {
      newList = newList
          .where((e) =>
              e.roomID!.toLowerCase().contains(valueSearch!.toLowerCase()))
          .toList();
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    kindItems = ['All'];
    kindItems.addAll(RoomKindModel.kindItems);
    return Scaffold(
        floatingActionButton: AuthServices.CurrentUserIsManager()
            ? FloatingActionButton(
                backgroundColor: ColorPalette.primaryColor,
                child: Text(
                  '+',
                  style: TextStyles.h1
                      .copyWith(color: ColorPalette.backgroundColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CreateRoomScreen.routeName);
                },
              )
            : Container(),
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
              child: Text('ROOMS',
                  style: TextStyles.slo.bold.copyWith(
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(3, 6),
                        blurRadius: 6,
                      )
                    ],
                  ))),
          centerTitle: true,
          toolbarHeight: kToolbarHeight * 1.5,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            color: ColorPalette.backgroundColor,
            // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
            child: Column(children: [
              const SizedBox(height: 36),
              Container(
                child: Container(
                  child: SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          valueSearch = value;
                        });
                      },
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
                              onTap: () {
                                setState(() {
                                  isVisibleFilter = !isVisibleFilter;
                                });
                              },
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
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                      visible: isVisibleFilter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FilterContainerWidget(
                            name: 'Price',
                            icon1: Icon(
                              FontAwesomeIcons.arrowDown,
                              size: 12,
                              color: priceDecrease
                                  ? ColorPalette.primaryColor
                                  : ColorPalette.blackText,
                            ),
                            icon2: Icon(
                              FontAwesomeIcons.arrowUp,
                              size: 12,
                              color: priceDecrease
                                  ? ColorPalette.blackText
                                  : ColorPalette.primaryColor,
                            ),
                            onTapIconDown: () {
                              setState(() {
                                priceDecrease = true;
                              });
                            },
                            onTapIconUp: () {
                              setState(() {
                                priceDecrease = false;
                              });
                            },
                          ),
                          Container(
                              width: 120,
                              height: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorPalette.grayText),
                                  borderRadius:
                                      BorderRadius.circular(kMediumPadding)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  alignment: Alignment.centerLeft,
                                  value: dropdownStatusValue,
                                  hint: Text(
                                    "Status",
                                    style: TextStyles.defaultStyle.grayText
                                        .copyWith(fontSize: 13),
                                  ),
                                  iconStyleData: IconStyleData(
                                      iconEnabledColor:
                                          ColorPalette.primaryColor),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownStatusValue = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: const EdgeInsets.only(left: 12),
                                    height: 28,
                                    width: 110,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 28,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMinPadding))),
                                  items: statusItems
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          onTap: () {
                                            setState(() {
                                              status = e;
                                              print(status);
                                            });
                                          },
                                          child: Text(
                                            e,
                                            style: TextStyles
                                                .defaultStyle.grayText,
                                          )))
                                      .toList(),
                                ),
                              )),
                          Container(
                              height: 28,
                              width: 145,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorPalette.grayText),
                                  borderRadius:
                                      BorderRadius.circular(kMediumPadding)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  alignment: Alignment.centerLeft,
                                  iconStyleData: IconStyleData(
                                      iconEnabledColor:
                                          ColorPalette.primaryColor),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMinPadding))),
                                  hint: Text(
                                    'Kind',
                                    style: TextStyles.defaultStyle.grayText,
                                  ),
                                  items: kindItems
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          onTap: () {
                                            setState(() {
                                              kindRoom = e;
                                            });
                                          },
                                          child: Text(
                                            e,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles
                                                .defaultStyle.grayText
                                                .copyWith(fontSize: 13),
                                          )))
                                      .toList(),
                                  buttonStyleData: const ButtonStyleData(
                                    padding: const EdgeInsets.only(left: 12),
                                    height: 28,
                                    width: 10,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 28,
                                  ),
                                  value: dropdownKindValue,
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownKindValue = value;
                                    });
                                  },
                                ),
                              ))
                        ],
                      ))),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 30),
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
                        return GridView.count(
                            padding:
                                const EdgeInsets.only(bottom: kMediumPadding),
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.8,
                            children: loadListRoom(listRoom)
                                .map((e) => RoomItem(
                                      room: e,
                                    ))
                                .toList());
                      } else
                        return Container();
                    }),
              )),
            ])));
  }
}
