import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';
import '../../../core/models/rentalform_mode.dart';
import '../../widgets/button_default.dart';
import '../../widgets/inputTitleWidget.dart';

class AddReceipt extends StatefulWidget {
  const AddReceipt({super.key});
  static final String routeName = 'add_receipt';

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<TableRow> listRow = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listRow.add(TitleRow());
    resetRentalForms();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            StreamBuilder(
                stream: FireBaseDataBase.readRentalForms(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    RentalFormModel.AllRentalFormModels = snapshot.data!;
                    resetRentalForms();
                  }
                  return Container();
                }),
            SizedBox(
              height: 60,
            ),
            InputTitleWidget(
              Title: 'Guest name',
              //controller: nameController,
              hintInput: 'Type here',
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: InputTitleWidget(
                Title: 'Address',
                //controller: ratioController,
                hintInput: 'Type here',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: InputTitleWidget(
                Title: 'Phone number',
                //controller: ratioController,
                hintInput: 'Type here',
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 10, left: 73),
              child: Text(
                'Dates',
                style: TextStyles.h6.copyWith(
                    color: ColorPalette.darkBlueText,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPalette.calendarGround.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(8)),
                child: TableCalendar(
                  focusedDay: _selectedDay ?? DateTime.now(),
                  firstDay: DateTime(2010),
                  lastDay: DateTime(2030),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: ColorPalette.primaryColor,
                        shape: BoxShape.circle),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    withinRangeDecoration: BoxDecoration(
                      color: ColorPalette.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    // rangeStartDecoration: BoxDecoration(
                    //     color: ColorPalette.primaryColor,
                    //     shape: BoxShape.circle),
                    // rangeEndDecoration: BoxDecoration(
                    //     color: ColorPalette.primaryColor,
                    //     shape: BoxShape.circle),
                    rangeHighlightColor: ColorPalette.primaryColor,
                    withinRangeTextStyle: TextStyle(color: Colors.white),
                  ),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  // rangeStartDay: _rangeStart,
                  // rangeEndDay: _rangeEnd,
                  // rangeSelectionMode: _rangeSelectionMode,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        // _focusedDay = focusedDay;
                        // _rangeStart =
                        //     null; // Important to clean those
                        // _rangeEnd = null;
                        // _rangeSelectionMode =
                        //     RangeSelectionMode.toggledOff;
                      });
                    }
                  },
                  // onRangeSelected: (start, end, focusedDay) {
                  //   setState(() {
                  //     _selectedDay = null;
                  //     _focusedDay = focusedDay;
                  //     _rangeStart = start;
                  //     _rangeEnd = end ?? start;
                  //     _rangeSelectionMode =
                  //         RangeSelectionMode.toggledOn;
                  //   });
                  //   soNgayDuocChon = DateTimeRange(
                  //       start: _rangeStart ?? DateTime.now(),
                  //       end: _rangeEnd ?? DateTime.now());
                  //   _soNgay = soNgayDuocChon.duration.inDays + 1;
                  // },
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                      color: ColorPalette.grayText,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4))),
                  columnWidths: {
                    0: FixedColumnWidth(40),
                    1: FixedColumnWidth(100),
                    2: FixedColumnWidth(140),
                    3: FixedColumnWidth(120),
                    //
                    for (int i = 0;
                        i < GuestKindModel.AllGuestKinds.length;
                        i++)
                      4 + i: FixedColumnWidth(160),
                    //
                    4 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(160),
                    5 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(120),
                    6 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(160),
                    7 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(200),
                    8 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(200),
                    9 + GuestKindModel.AllGuestKinds.length:
                        FixedColumnWidth(160),
                  },
                  children: listRow),
            ),
            Container(
                margin: EdgeInsets.only(top: 60, bottom: 80),
                width: 150,
                child: ButtonDefault(label: 'Create', onTap: () {})),
          ]),
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
              'Create Receipt',
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
            //alignment: Alignment.center,
          ),
          centerTitle: true,
          toolbarHeight: kToolbarHeight * 1.5,
        ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  void resetRentalForms() {
    listRow.clear();
    listRow.add(TitleRow());
    for (RentalFormModel rental in RentalFormModel.AllRentalFormModels) {
      TextEditingController _nameGuestController = TextEditingController();
      TextEditingController _cardIdGuestController = TextEditingController();
      TextEditingController _addressGuestController = TextEditingController();
      int numberOfForeignGuest = NumberOfForeignGuest(rental.GuestIDs);
      int days =
          _selectedDay?.difference(rental.BeginDate ?? DateTime.now()).inDays ??
              0;
      List<Widget> list = [
        Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
        ),
        Container(
          width: 200,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            rental.RoomID ?? '',
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
            (days).toString(),
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
            (rental.GuestIDs?.length).toString(),
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
                color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
      ];
      for (GuestKindModel guestKind in GuestKindModel.AllGuestKinds) {
        list.add(
          Container(
            width: 200,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              guestKind.Name ?? '',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
      list.addAll([
        Container(
          width: 200,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            RoomModel.getPriceWithRoomID(rental.RoomID ?? '').toString(),
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
            "0",
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
            '${DateFormat('dd/MM').format(rental.BeginDate ?? DateTime.now())} - ${DateFormat('dd/MM').format(_selectedDay ?? DateTime.now())}',
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
            '',
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
            'Total',
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
            'Total',
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
                color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
      ]);
      listRow.add(TableRow(children: list));
    }
  }

  NumberOfForeignGuest(List<String>? guestIDs) {
    int Result = 0;
    for (String guestID in guestIDs!)
      if (GuestModel.IsForeignGuest(guestID)) Result++;
    return Result;
  }

  SurchargeOfForeignGuests(
      {required int days, required int numberOfForeignGuest}) {
    if (numberOfForeignGuest > 0) {}
  }
}

TitleRow() {
  List<Widget> list = [
    Container(
      width: 50,
      height: 40,
      alignment: Alignment.center,
    ),
    Container(
      width: 200,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        'Room ID',
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
        'Days',
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
        'Guests',
        textAlign: TextAlign.center,
        style: TextStyles.defaultStyle.copyWith(
            color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
      ),
    ),
  ];
  for (GuestKindModel guestKind in GuestKindModel.AllGuestKinds) {
    list.add(
      Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          guestKind.Name ?? '',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
  list.addAll([
    Container(
      width: 200,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        'Unit Price',
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
        'Service',
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
        'Date',
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
        'Surcharge of foreign guests',
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
        'Excess customer surcharge ',
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
        'Total',
        textAlign: TextAlign.center,
        style: TextStyles.defaultStyle.copyWith(
            color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
      ),
    ),
  ]);
  return TableRow(children: list);
}
