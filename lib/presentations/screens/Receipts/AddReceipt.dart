import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/firebase_request.dart';
import '../../../core/models/rental_form_model.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dialog.dart';
import '../../widgets/inputTitleWidget.dart';

class AddReceipt extends StatefulWidget {
  AddReceipt({super.key});
  static final String routeName = 'add_receipt';
  int TotalPrice = 0;
  void updateTotalPrice(NewTotalPrice) {
    TotalPrice = NewTotalPrice;
  }

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  DateTime? _selectedDay = DateTime.now();
  List<TableRow> listRow = [];
  StreamController<int> TotalPriceStream = StreamController<int>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<String> RentalFormIDs = [];
  List<String> RoomIDs = [];
  TextEditingController phoneNumberController = TextEditingController();

  void updatePrice(int newPrice) {
    TotalPriceStream.sink.add(newPrice);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listRow.add(TitleRow());
    resetRentalForms();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TotalPriceStream.close();
    super.dispose();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorPalette.primaryColor;
    }
    return ColorPalette.primaryColor;
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
            SizedBox(
              height: 60,
            ),
            InputTitleWidget(
              Title: 'Guest name',
              controller: nameController,
              hintInput: 'Type here',
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: InputTitleWidget(
                Title: 'Address',
                controller: addressController,
                hintInput: 'Type here',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: InputTitleWidget(
                Title: 'Phone number',
                controller: phoneNumberController,
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
                        widget.TotalPrice = 0;
                        updatePrice(widget.TotalPrice);
                        RentalFormIDs.clear();
                        RoomIDs.clear();
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
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 40, left: 73),
              child: Text(
                'All rental forms',
                style: TextStyles.h6.copyWith(
                    color: ColorPalette.darkBlueText,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                      color: ColorPalette.grayText,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(40),
                      1: FixedColumnWidth(100),
                      2: FixedColumnWidth(60),
                      3: FixedColumnWidth(80),
                      //
                      for (int i = 0;
                          i < GuestKindModel.AllGuestKinds.length;
                          i++)
                        4 + i: FixedColumnWidth(120),
                      //
                      4 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(100),
                      5 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(80),
                      6 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(140),
                      7 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(200),
                      8 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(200),
                      9 + GuestKindModel.AllGuestKinds.length:
                          FixedColumnWidth(100),
                    },
                    children: listRow),
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 40, bottom: 20),
                  child: Text(
                    'Total',
                    style: TextStyles.h4.copyWith(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 20, right: 40, bottom: 20),
                    child: StreamBuilder<int>(
                      stream: TotalPriceStream.stream,
                      initialData: 0,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        return Text(
                          '${NumberFormat.decimalPattern().format(snapshot.data)} VND',
                          style: TextStyles.h4.copyWith(
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w500),
                        );
                      },
                    )),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 50),
                width: 150,
                child: ButtonDefault(label: 'Create', onTap: createRecept)),
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
    widget.TotalPrice = 0;
    RentalFormIDs.clear();
    RoomIDs.clear();
    updatePrice(widget.TotalPrice);
    for (RentalFormModel rental
        in RentalFormModel.AllUnpaidRentalFormModels()) {
      int days = _selectedDay?.difference(rental.BeginDate).inDays ?? 0;
      if (days == 0) {
        days = 1;
      }
      bool isChecked = false;
      List<Widget> list = [
        Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateColor.resolveWith(
                    (states) => getColor(states)),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    if (days < 0) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogOverlay(
                              isSuccess: false,
                              task: 'Choose rental form',
                              error:
                                  'Checkout date cannot be before booking date',
                            );
                          });
                    } else {
                      isChecked = !isChecked;
                      if (isChecked) {
                        widget.TotalPrice += rental.Total(days);
                        RentalFormIDs.add(rental.RentalID);
                        RoomIDs.add(rental.RoomID);
                      } else {
                        widget.TotalPrice -= rental.Total(days);
                        RentalFormIDs.remove(rental.RentalID);
                        RoomIDs.remove(rental.RoomID);
                      }
                      updatePrice(widget.TotalPrice);
                    }
                  });
                },
              );
            },
          ),
        ),
        Container(
          width: 200,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            rental.RoomID,
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
            (rental.GuestIDs.length).toString(),
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
                color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
      ];
      for (GuestKindModel guestKind in GuestKindModel.AllGuestKinds) {
        int numberOfGuestKind =
            NumberOfGuestKind(rental.GuestIDs, guestKind.GuestKindID);

        list.add(
          Container(
            width: 200,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              numberOfGuestKind.toString(),
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
            NumberFormat.decimalPattern()
                .format(RoomModel.getPriceWithRoomID(rental.RoomID)),
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
            '${DateFormat('dd/MM').format(rental.BeginDate)} - ${DateFormat('dd/MM').format(_selectedDay ?? DateTime.now())}',
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
            NumberFormat.decimalPattern()
                .format(rental.GuestKindSurcharge(days)),
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
            NumberFormat.decimalPattern()
                .format(rental.ExcessCustomerSurcharge(days)),
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
            NumberFormat.decimalPattern().format(rental.Total(days)),
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
                color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
      ]);
      listRow.add(TableRow(children: list));
    }
  }

  NumberOfGuestKind(List<String>? guestIDs, String guestKindID) {
    int Result = 0;
    for (String guestID in guestIDs!)
      if (GuestModel.IsSameGuestKind(guestID, guestKindID)) Result++;
    return Result;
  }

  void changeRentalFormState(String rentalFormID) {
    try {
      CollectionReference roomCollection =
          FirebaseFirestore.instance.collection(RentalFormModel.CollectionName);
      FirebaseFirestore.instance
          .collection(RentalFormModel.CollectionName)
          .where("RentalID", isEqualTo: rentalFormID)
          .get()
          .then((value) {
        DocumentReference document = roomCollection.doc(value.docs[0].id);
        document.update({"Status": "Paid"});
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Check out ${rentalFormID}',
              error: e.toString(),
            );
          });
    }
  }

  void changeStateRoom(String roomID) {
    try {
      CollectionReference roomCollection =
          FirebaseFirestore.instance.collection('Rooms');
      FirebaseFirestore.instance
          .collection('Rooms')
          .where("roomID", isEqualTo: roomID)
          .get()
          .then((value) {
        DocumentReference document = roomCollection.doc(value.docs[0].id);
        document.update({"State": "Available"});
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Check out ${roomID}',
              error: e.toString(),
            );
          });
    }
  }

  void createRecept() {
    if (nameController.text == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Receipt',
              error: "Check input guest Name, please!!!",
            );
          });
    } else if (addressController.text == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Receipt',
              error: "Check input address, please!!!",
            );
          });
    } else if (phoneNumberController.text == '') {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Create Receipt',
              error: "Check input phone number, please!!!",
            );
          });
    } else {
      try {
        DocumentReference doc = FirebaseFirestore.instance
            .collection(ReceiptModel.CollectionName)
            .doc();
        ReceiptModel receipt = new ReceiptModel(
            receiptID: doc.id,
            guestName: nameController.text,
            rentalFormIDs: RentalFormIDs,
            phoneNumber: phoneNumberController.text,
            checkOutDate: _selectedDay,
            total: widget.TotalPrice,
            address: addressController.text);
        for (String rentalFormID in RentalFormIDs)
          changeRentalFormState(rentalFormID);
        for (String roomID in RoomIDs) changeStateRoom(roomID);

        doc.set(receipt.toJson()).whenComplete(() {
          showDialog(
              context: context,
              builder: (context) {
                return DialogOverlay(
                  isSuccess: true,
                  task: 'Create Receipt',
                );
              });

          setState(() {
            addressController.text = '';
            nameController.text = '';
            phoneNumberController.text = '';
            _selectedDay = DateTime.now();
            widget.TotalPrice = 0;
            updatePrice(widget.TotalPrice);
            RentalFormIDs.clear();
            RoomIDs.clear();
          });
        });
      } catch (e) {}
    }
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
          (guestKind.Name) + ' (${guestKind.ratio})',
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
        'Surcharge of guest kinds',
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
