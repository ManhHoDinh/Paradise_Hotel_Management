import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/presentations/screens/Receipts/AddReceipt.dart';
import 'package:paradise/presentations/widgets/receipt_item.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';
import '../../../core/models/room_kind_model.dart';
import '../../../core/models/room_model.dart';
import '../../widgets/filter_containter_widget.dart';
import '../../widgets/room_item.dart';
import '../Rooms/CreateRoom_screen.dart';

class SeeAllReceipts extends StatefulWidget {
  const SeeAllReceipts({super.key});
  static final String routeName = 'see_all_receipt';

  @override
  State<SeeAllReceipts> createState() => _SeeAllReceiptsState();
}

class _SeeAllReceiptsState extends State<SeeAllReceipts> {
  late List<ReceiptModel> Receipts;
  bool isVisibleFilter = false;
  bool priceDecrease = false;
  String? kindRoom;
  String? valueSearch;
  String? dropdownKindValue;
  String? dropdownStatusValue;
  List<String> kindItems = ['All'];
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
  List<ReceiptModel> loadReceipts(List<ReceiptModel> list) {
    List<ReceiptModel> newList = List.from(list);

    if (priceDecrease) {
      //list.sort((a, b) => b.getPrice().compareTo(a.getPrice()));
    } else {
      //list.sort((a, b) => a.getPrice().compareTo(b.getPrice()));
    }
    // if (kindRoom == 'All') {
    //   newList = newList;
    // } else if (kindRoom != null) {
    //   newList = newList
    //       .where((room) =>
    //           RoomKindModel.getRoomKindName(room.receiptID ?? '') == kindRoom)
    //       .toList();
    // }
    // if (valueSearch != null) {
    //   newList = newList
    //       .where((e) =>
    //           e.receiptID!.toLowerCase().contains(valueSearch!.toLowerCase()))
    //       .toList();
    // }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    kindItems = ['All'];
    kindItems.addAll(RoomKindModel.kindItems);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPalette.primaryColor,
          child: Text(
            '+',
            style: TextStyles.h1.copyWith(color: ColorPalette.backgroundColor),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddReceipt.routeName);
          },
        ),
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
              child: Text('Receipts',
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
              StreamBuilder(
                  stream: FireBaseDataBase.readRentalForms(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      RentalFormModel.AllRentalFormModels = snapshot.data!;
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
                              height: 28,
                              width: 140,
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
                child: StreamBuilder<List<ReceiptModel>>(
                    stream: FireBaseDataBase.readReceipts(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        Receipts = snapshot.data!;
                        ReceiptModel.AllReceipts = snapshot.data!;
                        return GridView.count(
                            padding:
                                const EdgeInsets.only(bottom: kMediumPadding),
                            crossAxisCount: 2,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.8,
                            children: loadReceipts(Receipts)
                                .map((e) => ReceiptItem(
                                      Receipt: e,
                                    ))
                                .toList());
                      } else
                        return Container();
                    }),
              )),
            ])));
  }
}
