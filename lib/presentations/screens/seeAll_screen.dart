import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/rental_form.dart';
import 'package:paradise/presentations/widgets/filter_containter_widget.dart';
import 'package:paradise/presentations/widgets/room_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/image_helper.dart';
import '../widgets/button_default.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late List<RoomModel> listRoom;
  bool isVisibleFilter = false;
  bool priceDecrease = false;
  String? kindRoom;
  String? status;
  String? valueSearch;
  String? dropdownKindValue;
  String? dropdownStatusValue;
  final kindItems = ['All', 'Family room', 'Master room', 'Couple room'];
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
        switch (status) {
          case "All":
            newList = list;
            break;
          case "Booked":
            newList = newList.where((room) => room.State! == 'Booked').toList();
            break;
          case "Available":
            newList =
                newList.where((room) => room.State! == 'Available').toList();
            break;
          default:
            newList = newList;
        }
        break;
      case "Family room":
        newList = newList.where((room) => room.type! == 'Family Room').toList();
        break;
      case "Couple room":
        newList = newList.where((room) => room.type! == 'Couple Room').toList();
        break;
      case "Master room":
        newList = newList.where((room) => room.type! == 'Master Room').toList();
        break;
      default:
        newList = newList;
    }
    if (valueSearch != null) {
      newList = newList
          .where(
              (e) => e.type!.toLowerCase().contains(valueSearch!.toLowerCase()))
          .toList();
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<RoomModel>> readRooms() => FirebaseFirestore.instance
        .collection('Rooms')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => RoomModel.fromJson(doc.data()))
            .toList());
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
            'ROOMS',
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
                child: Text(
                  'ROOM OPTIONS',
                  style: TextStyles.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.primaryColor),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: ButtonDefault(
                      label: 'Book Room',
                      onTap: () {
                        Navigator.of(context).pushNamed(RentalForm.routeName);
                      })),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: ButtonDefault(label: 'Create New Room', onTap: () {})),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: ButtonDefault(label: 'Edit Room', onTap: () {})),
            ],
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
                                  style: TextStyles.defaultStyle.grayText,
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
                                          style:
                                              TextStyles.defaultStyle.grayText,
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
                                          style:
                                              TextStyles.defaultStyle.grayText,
                                        )))
                                    .toList(),
                                buttonStyleData: const ButtonStyleData(
                                  padding: const EdgeInsets.only(left: 12),
                                  height: 28,
                                  width: 120,
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
                    child: StreamBuilder<List<RoomModel>>(
                        stream: readRooms(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'Something went wrong! ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            listRoom = snapshot.data!;
                            return GridView.builder(
                              padding:
                                  const EdgeInsets.only(bottom: kMediumPadding),
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
                                  image: listRoom[i].PrimaryImage ?? '',
                                  name: listRoom[i].name ?? '',
                                  type: listRoom[i].type ?? '',
                                  cost: listRoom[i].price ?? 0,
                                  status: listRoom[i].State ?? ''),

                              itemCount: listRoom.length,
                            );
                          } else
                            return Container();
                        })
                    //  GridView.count(
                    //     padding: const EdgeInsets.only(bottom: kMediumPadding),
                    //     crossAxisCount: 2,
                    //     mainAxisSpacing: 24,
                    //     crossAxisSpacing: 24,
                    //     childAspectRatio: 0.8,
                    //     children: loadListRoom(widget.listRoom)
                    //         .map(
                    //           (e) => InkWell(
                    //             onTap: () {},
                    //             child: RoomItem(
                    //                 image: e.PrimaryImage ?? AssetHelper.room1,
                    //                 name: e.name ?? '',
                    //                 type: e.type ?? '',
                    //                 cost: e.price ?? 0,
                    //                 status: e.State ?? ''),
                    //           )
                    //           //  RoomItem(
                    //           //         e.PrimaryImage ?? AssetHelper.room1,
                    //           //         e.name ?? '',
                    //           //         e.type ?? '',
                    //           //         e.State?? '',

                    //           //         e.price ?? 0)
                    //           ,
                    //         )
                    //         .toList()),
                    )),
          ])),
    );
  }
}
