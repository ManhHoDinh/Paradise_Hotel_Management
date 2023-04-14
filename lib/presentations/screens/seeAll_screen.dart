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
import 'package:paradise/presentations/widgets/filter_containter_widget.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';

class SeeAllScreen extends StatefulWidget {
  final List<RoomModel> listRoom;
  const SeeAllScreen({super.key, required this.listRoom});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
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
    List<RoomModel> newList = List.from(list);

    if (priceDecrease) {
      list.sort((a, b) => b.price!.compareTo(a.price!));
    } else {
      list.sort((a, b) => a.price!.compareTo(b.price!));
    }
    switch (status) {
      case "All":
        newList = list;
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

    switch (kindRoom) {
      case "All":
        newList = list;
        break;
      case "Family room":
        newList =
            newList.where((room) => room.RoomKindID! == 'Family Room').toList();
        break;
      case "Couple room":
        newList =
            newList.where((room) => room.RoomKindID! == 'Couple Room').toList();
        break;
      case "Master room":
        newList =
            newList.where((room) => room.RoomKindID! == 'Master Room').toList();
        break;
      default:
        newList = newList;
    }
    if (valueSearch != null) {
      newList = newList
          .where((e) =>
              e.RoomKindID!.toLowerCase().contains(valueSearch!.toLowerCase()))
          .toList();
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorPalette.backgroundColor,
          leading: InkWell(
            customBorder: CircleBorder(),
            onTap: () {},
            child: Container(
              child: Icon(
                FontAwesomeIcons.bars,
                color: ColorPalette.primaryColor,
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
                            name: 'price',
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
                              width: 100,
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
                                    width: 120,
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
                              width: 120,
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
                                  items: RoomKindModel.kindItems
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
                                    width: 150,
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
              Container(
                padding: const EdgeInsets.only(bottom: kMinPadding),
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      customBorder: CircleBorder(),
                      child: Container(
                        width: 26,
                        height: 26,
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          size: 18,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'All room',
                    style: TextStyles.defaultStyle.primaryTextColor,
                  ),
                ]),
              ),
              Expanded(
                  child: Container(
                //padding: const EdgeInsets.only(bottom: kMediumPadding),
                child: GridView.count(
                    padding: const EdgeInsets.only(bottom: kMediumPadding),
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.8,
                    children: loadListRoom(widget.listRoom)
                        .map(
                          (e) => RoomItem(
                            room: e,
                          )
                          //  RoomItem(
                          //         e.PrimaryImage ?? AssetHelper.room1,
                          //         e.name ?? '',
                          //         e.type ?? '',
                          //         e.State?? '',

                          //         e.price ?? 0)
                          ,
                        )
                        .toList()),
              )),
            ])));
  }
}
