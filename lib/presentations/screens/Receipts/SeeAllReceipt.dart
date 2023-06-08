import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/presentations/screens/Receipts/AddReceipt.dart';
import 'package:paradise/presentations/widgets/fetchDataWidget.dart';
import 'package:paradise/presentations/widgets/receipt_item.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';

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
  String? valueSearch;
  String? Month;
  String? dropdownMonthValue;
  String? Year;
  String? dropdownYearValue;

  List<String> monthItems = [
    'ALL',
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER'
  ];
  List<String> yearItems = [
    'ALL',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
  ];

  List<ReceiptModel> loadReceipts(List<ReceiptModel> list) {
    List<ReceiptModel> newList = List.from(list);
    // newList.sort((a, b) => b.checkOutDate.compareTo(a.checkOutDate));

    // if (priceDecrease) {
    //   newList.sort((a, b) => (b.total).compareTo(a.total));
    // } else {
    //   newList.sort((a, b) => (a.total).compareTo(b.total));
    // }
    if (Month == 'ALL') {
      newList = newList;
    } else if (Month != null) {
      newList = newList
          .where((element) =>
              (element.checkOutDate.month == (monthItems.indexOf(Month ?? ''))))
          .toList();
    }
    if (Year == 'ALL') {
      newList = newList;
    } else if (Year != null) {
      newList = newList
          .where((element) =>
              (element.checkOutDate.year == (int.parse(Year ?? ''))))
          .toList();
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              'RECEIPTS',
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
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            color: ColorPalette.backgroundColor,
            // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
            child: Column(children: [
              const SizedBox(height: 50),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                      visible: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                    'Month',
                                    style: TextStyles.defaultStyle.grayText,
                                  ),
                                  items: monthItems
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          onTap: () {
                                            setState(() {
                                              Month = e;
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
                                  value: dropdownMonthValue,
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownMonthValue = value;
                                    });
                                  },
                                ),
                              )),
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
                                    'Year',
                                    style: TextStyles.defaultStyle.grayText,
                                  ),
                                  items: yearItems
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          onTap: () {
                                            setState(() {
                                              Year = e;
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
                                  value: dropdownYearValue,
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownYearValue = value;
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
