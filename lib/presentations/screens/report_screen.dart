import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/api/pdf_report_api.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/core/models/report_item.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import '../../api/pdf_api.dart';
import '../../core/constants/color_palatte.dart';
import '../../core/constants/dimension_constants.dart';
import '../../core/helpers/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path/path.dart' as path;

import '../../core/models/report.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  static final String routeName = 'report_screen';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isPressed = false;

  String? dropdownMonthReportValue;
  String? dropdownYearReportValue;
  String? monthSelected;
  String? yearSelected;
  String? yearOfMonthReportSelected;
  int totalMonthPrice = 0;
  int totalYearPrice = 0;
  List<RoomKindModel> listRoomKind = [];
  List<RoomModel> listRoom = [];
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

  List<ReportItem> getListReportItem() {
    List<ReportItem> listReportItem = [];
    for (int i = 0; i < RoomKindModel.AllRoomKinds.length; i++) {
      RoomKindModel roomKind = RoomKindModel.AllRoomKinds[i];
      int revenue = getRevenueOfMonthReport(roomKind);
      listReportItem.add(ReportItem(
          roomType: roomKind.Name!,
          revenue: revenue,
          rate: Rate(revenue, totalMonthPrice)));
    }
    return listReportItem;
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
          toolbarHeight: kMaxPadding * 2,
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
            child: Text('REPORT', style: TextStyles.h8),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            //margin: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: Column(children: [
              StreamBuilder(
                  stream: FireBaseDataBase.readRoomKinds(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      RoomKindModel.AllRoomKinds = snapshot.data!;
                    }
                    return Container();
                  }),
              StreamBuilder(
                  stream: FireBaseDataBase.readReceipts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      ReceiptModel.AllReceipts = snapshot.data!;
                    }
                    return Container();
                  }),
              SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  Container(
                    height: 42,
                    width: 150,
                    margin: EdgeInsets.only(right: 10, left: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPalette.grayText),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        alignment: Alignment.center,
                        value: dropdownMonthReportValue,
                        hint: Text(
                          "MONTHLY",
                          style: TextStyles.defaultStyle.copyWith(
                              fontSize: 16,
                              color: ColorPalette.calendarGround,
                              fontWeight: FontWeight.bold),
                        ),
                        iconStyleData: IconStyleData(
                            iconEnabledColor: ColorPalette.grayText,
                            iconSize: 36),
                        onChanged: (value) {
                          setState(() {
                            dropdownMonthReportValue = value;
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
                                borderRadius:
                                    BorderRadius.circular(kMinPadding))),
                        items: monthItems
                            .map((e) => DropdownMenuItem(
                                value: e,
                                onTap: () {
                                  setState(() {
                                    monthSelected = e;
                                    ResetTotalOfMonth();
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
                  Spacer(),
                  Container(
                    height: 42,
                    width: 150,
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPalette.grayText),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        alignment: Alignment.center,
                        value: yearOfMonthReportSelected,
                        hint: Text(
                          "YEARLY",
                          style: TextStyles.defaultStyle.copyWith(
                              fontSize: 16,
                              color: ColorPalette.calendarGround,
                              fontWeight: FontWeight.bold),
                        ),
                        iconStyleData: IconStyleData(
                            iconEnabledColor: ColorPalette.grayText,
                            iconSize: 36),
                        onChanged: (value) {
                          setState(() {
                            yearOfMonthReportSelected = value!;
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
                                borderRadius:
                                    BorderRadius.circular(kMinPadding))),
                        items: yearItems
                            .map((e) => DropdownMenuItem(
                                value: e,
                                onTap: () {
                                  setState(() {
                                    yearOfMonthReportSelected = e;
                                    ResetTotalOfMonth();
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    e,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.defaultStyle.copyWith(
                                        color: ColorPalette.calendarGround,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                ],
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
                rows: [
                  for (int i = 1; i <= RoomKindModel.AllRoomKinds.length; i++)
                    DataRow(cells: [
                      DataCell(
                        Center(
                          child: Text(
                            '${i}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${RoomKindModel.AllRoomKinds[i - 1].Name}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${NumberFormat.decimalPattern().format(getRevenueOfMonthReport(RoomKindModel.AllRoomKinds[i - 1]))}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${NumberFormat('#.##', 'en_US').format(Rate(getRevenueOfMonthReport(RoomKindModel.AllRoomKinds[i - 1]), totalMonthPrice) * 100)}%',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ])
                ],
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
                        'Room Type',
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
              )),
              SizedBox(
                height: kMediumPadding,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                    Text(
                        '${NumberFormat.decimalPattern().format(totalMonthPrice)} VND',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Material(
                color: ColorPalette.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.black38,
                  onTap: () async {
                    List<ReportItem> listReportItem = getListReportItem();

                    final report = Report(items: listReportItem);
                    final pdfFile = await PdfReportApi.generate(
                        report,
                        yearOfMonthReportSelected!,
                        monthSelected!,
                        totalMonthPrice);
                    PdfApi.openFile(pdfFile);
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Print',
                      style: TextStyles.h8.copyWith(
                          color: ColorPalette.backgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                                ResetTotalOfYear();
                              });
                            },
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
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
                rows: [
                  for (int i = 1; i <= RoomKindModel.AllRoomKinds.length; i++)
                    DataRow(cells: [
                      DataCell(
                        Center(
                          child: Text(
                            '${i}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${RoomKindModel.AllRoomKinds[i - 1].Name}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${NumberFormat.decimalPattern().format(getRevenueOfYearReport(RoomKindModel.AllRoomKinds[i - 1]))}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${NumberFormat('#.##', 'en_US').format(Rate(getRevenueOfYearReport(RoomKindModel.AllRoomKinds[i - 1]), totalYearPrice) * 100)}%',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ])
                ],
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
                        'Room Type',
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
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL',
                        style: TextStyles.defaultStyle.bold.copyWith(
                          color: ColorPalette.greenText,
                        )),
                    Text(
                        '${NumberFormat.decimalPattern().format(totalYearPrice)} VND',
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
                    getListReportItem();
                    // final report = Report(items: listReportItem);
                    generatePDF();
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Print',
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

  int getRevenueOfMonthReport(RoomKindModel RoomKind) {
    try {
      int result = 0;

      List<ReceiptModel> filterYearReceipts = [];
      filterYearReceipts.addAll(ReceiptModel.AllReceipts.where((element) =>
          element.checkOutDate!.year ==
          (int.parse(yearOfMonthReportSelected ?? ''))));

      List<ReceiptModel> filterMonthReceipts = [];
      filterMonthReceipts.addAll(filterYearReceipts.where((element) =>
          element.checkOutDate!.month ==
          (monthItems.indexOf(monthSelected ?? '') + 1)));
      //RentalFormModel rentalFormModelOfMonth= RentalFormModel.AllRentalFormModels.where((element) => false);

      for (ReceiptModel receipt in filterMonthReceipts) {
        result += getRentalFormFee(
            receipt.rentalFormIDs, receipt.checkOutDate!, RoomKind);
      }
      return result;
    } catch (e) {
      return 0;
    }
  }

  int getRevenueOfYearReport(RoomKindModel RoomKind) {
    try {
      int result = 0;

      List<ReceiptModel> filterYearReceipts = [];
      filterYearReceipts.addAll(ReceiptModel.AllReceipts.where((element) =>
          element.checkOutDate!.year == (int.parse(yearSelected ?? ''))));

      for (ReceiptModel receipt in filterYearReceipts) {
        result += getRentalFormFee(
            receipt.rentalFormIDs, receipt.checkOutDate!, RoomKind);
      }
      return result;
    } catch (e) {
      return 0;
    }
  }

  int getRentalFormFee(List<String> rentalFormIDs, DateTime checkOutDate,
      RoomKindModel roomKind) {
    try {
      int result = 0;
      for (String rentalFormID in rentalFormIDs) {
        RentalFormModel rental = RentalFormModel.AllRentalFormModels.where(
            (element) => element.RentalID == rentalFormID).first;
        int days = checkOutDate.difference(rental.BeginDate).inDays;
        if (days == 0) days = 1;
        RoomModel room = rental.getRoom();
        if (room.RoomKindID == roomKind.RoomKindID)
          result += rental.Total(days);
      }
      return result;
    } catch (e) {
      return 0;
    }
  }

  void ResetTotalOfMonth() {
    setState(() {
      totalMonthPrice = 0;
      for (int i = 1; i <= RoomKindModel.AllRoomKinds.length; i++)
        totalMonthPrice +=
            getRevenueOfMonthReport(RoomKindModel.AllRoomKinds[i - 1]);
    });
  }

  void ResetTotalOfYear() {
    setState(() {
      totalYearPrice = 0;
      for (int i = 1; i <= RoomKindModel.AllRoomKinds.length; i++)
        totalYearPrice +=
            getRevenueOfYearReport(RoomKindModel.AllRoomKinds[i - 1]);
    });
  }

  double Rate(int revenue, int totalPrice) {
    try {
      if (totalPrice == 0) return 0;
      return revenue / totalPrice;
    } catch (e) {
      return 0;
    }
  }

  Future<void> generatePDF() async {
    PdfDocument document = PdfDocument();
    var page = document.pages.add();
    page.graphics
        .drawString('binh đây', PdfStandardFont(PdfFontFamily.helvetica, 30));

    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    // final path = (await getExternalStorageDirectory())!.path;
    // final file = File('$path/$fileName');
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open('$path/$fileName');
    final result = await FilePicker.platform.getDirectoryPath();
    String? selectedPath;

    if (result != null) {
      selectedPath = result;

      final file = File(path.join(selectedPath, fileName));
      await file.writeAsBytes(bytes, flush: true);
      await OpenFile.open(file.path);
    }
  }
}
