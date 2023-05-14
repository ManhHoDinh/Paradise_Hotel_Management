import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/kind_room_service.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/dimension_constants.dart';
import '../../core/helpers/assets_helper.dart';
import '../../core/helpers/text_styles.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  static final String routeName = '/report_screen';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isPressed = false;

  String? dropdownMonthReportValue;
  String? dropdownYearReportValue;
  String? monthSelected;
  String? yearSelected;
  int totalMonthPrice = 10202;
  int totalYearPrice = 10202;
  late List<RoomKindModel> listRoomKind;
  late List<RoomModel> listRoom;
  List<TableRow> listMonthReports = [
    TableRow(children: [
      Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'No',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Room type',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Revenue(VND)',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Rate',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ]),
  ];
  List<TableRow> listYearReports = [
    TableRow(children: [
      Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'No',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Room type',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Revenue(VND)',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          'Rate',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    ]),
  ];

  List<String> monthItems = [
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
    '2022',
    '2023',
  ];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('RoomKind').get().then((value) {
      listRoomKind =
          value.docs.map((e) => RoomKindModel.fromJson(e.data())).toList();
    });
    FirebaseFirestore.instance.collection('Rooms').get().then((value) {
      listRoom = value.docs.map((e) => RoomModel.fromJson(e.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    // listRoomKind = RoomKindModel.AllRoomKinds;
    //listRoom = RoomModel.AllRooms;
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kMaxPadding * 2.5,
          elevation: 5,
          //
          backgroundColor: ColorPalette.primaryColor.withOpacity(0.75),
          leading: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {
              setState(() {
                isPressed = param;
              });
            },
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: isPressed
                    ? ColorPalette.primaryColor
                    : ColorPalette.backgroundColor,
              ),
            ),
          ),
          title: Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('REPORT', style: TextStyles.h8),
                    )),
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Image.asset(AssetHelper.iconMenu),
                ))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            //margin: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: Column(children: [
              SizedBox(
                height: 28,
              ),
              Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.grayText),
                    borderRadius: BorderRadius.circular(kMediumPadding)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    alignment: Alignment.center,
                    value: dropdownMonthReportValue,
                    hint: Text(
                      "MONTHLY REPORT",
                      style: TextStyles.defaultStyle.copyWith(
                          fontSize: 16,
                          color: ColorPalette.calendarGround,
                          fontWeight: FontWeight.bold),
                    ),
                    iconStyleData: IconStyleData(
                        iconEnabledColor: ColorPalette.grayText, iconSize: 36),
                    onChanged: (value) {
                      setState(() {
                        dropdownMonthReportValue = value;

                        switch (dropdownMonthReportValue) {
                          case 'JANUARY':
                            break;

                          case 'FEBRUARY':
                            break;
                          case 'MARCH':
                            break;
                          case 'APRIL':
                            break;
                          case 'MAY':
                            break;
                          case 'JUNE':
                            break;
                          case 'JULY':
                            break;
                          case 'AUGUST':
                            break;
                          case 'SEPTEMBER':
                            break;
                          case 'OCTOBER':
                            break;
                          case 'NOVEMBER':
                            break;
                          case 'DECEMBER':
                            break;
                        }
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                        padding: const EdgeInsets.only(left: 20),
                        height: 42,
                        width: 200),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMinPadding))),
                    items: monthItems
                        .map((e) => DropdownMenuItem(
                            value: e,
                            onTap: () {
                              setState(() {
                                monthSelected = e;
                              });
                            },
                            child: Text(
                              e,
                              style: TextStyles.defaultStyle.copyWith(
                                  color: ColorPalette.calendarGround,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                  child: DataTable(
                horizontalMargin: 10,
                columnSpacing: 20,
                border: TableBorder.all(
                    color: ColorPalette.grayText,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4))),
                rows: [],
                columns: [
                  DataColumn(
                      label: Container(
                    width: width * .05,
                    alignment: Alignment.center,
                    child: Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: TextStyles.defaultStyle.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  DataColumn(
                    label: Container(
                      width: width * .25,
                      alignment: Alignment.center,
                      child: Text(
                        'Family room',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: width * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        'Revenue(VND)',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: width * .1,
                      alignment: Alignment.center,
                      child: Text(
                        'Rate',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )

                  //  Table(
                  //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  //     border: TableBorder.all(
                  //         color: ColorPalette.grayText,
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(4),
                  //             topRight: Radius.circular(4))),
                  //     columnWidths: {
                  //       0: FlexColumnWidth(1),
                  //       1: FlexColumnWidth(3),
                  //       2: FlexColumnWidth(4),
                  //       3: FlexColumnWidth(2),
                  //     },
                  //     children: listMonthReports),
                  ),
              SizedBox(
                height: kMediumPadding,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                    Text('$totalMonthPrice',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Material(
                color: ColorPalette.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.black38,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(listRoom.length.toString())));
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Print  ',
                      style: TextStyles.h8.copyWith(
                          color: ColorPalette.backgroundColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.grayText),
                    borderRadius: BorderRadius.circular(kMediumPadding)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    alignment: Alignment.center,
                    value: dropdownYearReportValue,
                    hint: Text(
                      "YEARLY REPORT",
                      style: TextStyles.defaultStyle.copyWith(
                          fontSize: 16,
                          color: ColorPalette.calendarGround,
                          fontWeight: FontWeight.bold),
                    ),
                    iconStyleData: IconStyleData(
                        iconEnabledColor: ColorPalette.grayText, iconSize: 36),
                    onChanged: (value) {
                      setState(() {
                        dropdownYearReportValue = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                        padding: const EdgeInsets.only(left: 36),
                        height: 42,
                        width: 200),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMinPadding))),
                    items: yearItems
                        .map((e) => DropdownMenuItem(
                            value: e,
                            onTap: () {
                              setState(() {
                                yearSelected = e;
                              });
                            },
                            child: Text(
                              e,
                              style: TextStyles.defaultStyle.copyWith(
                                  color: ColorPalette.calendarGround,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  child: DataTable(
                horizontalMargin: 10,
                columnSpacing: 20,
                border: TableBorder.all(
                    color: ColorPalette.grayText,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4))),
                rows: [],
                columns: [
                  DataColumn(
                      label: Container(
                    width: width * .05,
                    alignment: Alignment.center,
                    child: Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: TextStyles.defaultStyle.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  DataColumn(
                    label: Container(
                      width: width * .25,
                      alignment: Alignment.center,
                      child: Text(
                        'Family room',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: width * 0.3,
                      alignment: Alignment.center,
                      child: Text(
                        'Revenue(VND)',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: width * .1,
                      alignment: Alignment.center,
                      child: Text(
                        'Rate',
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )

                  //  Table(
                  //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  //     border: TableBorder.all(
                  //         color: ColorPalette.grayText,
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(4),
                  //             topRight: Radius.circular(4))),
                  //     columnWidths: {
                  //       0: FlexColumnWidth(1),
                  //       1: FlexColumnWidth(3),
                  //       2: FlexColumnWidth(4),
                  //       3: FlexColumnWidth(2),
                  //     },
                  //     children: listMonthReports),
                  ),
              SizedBox(
                height: kMediumPadding,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                    Text('$totalYearPrice',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                  ],
                ),
              ),
              // Table(
              //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //     border: TableBorder.all(
              //         color: ColorPalette.grayText,
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(4),
              //             topRight: Radius.circular(4))),
              //     columnWidths: {
              //       0: FlexColumnWidth(1),
              //       1: FlexColumnWidth(3),
              //       2: FlexColumnWidth(4),
              //       3: FlexColumnWidth(2),
              //     },
              //     children: listMonthReports),
              // SizedBox(
              //   height: kMediumPadding,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('TOTAL',
              //         style: TextStyles.defaultStyle.bold.copyWith(
              //           color: ColorPalette.greenText,
              //         )),
              //     Text('$totalYearPrice',
              //         style: TextStyles.defaultStyle.bold.copyWith(
              //           color: ColorPalette.greenText,
              //         )),
              //   ],
              // ),
              SizedBox(
                height: 32,
              ),
              Material(
                color: ColorPalette.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.black38,
                  onTap: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('${listRoomKind.length}')));
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Print  ',
                      style: TextStyles.h8.copyWith(
                          color: ColorPalette.backgroundColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
