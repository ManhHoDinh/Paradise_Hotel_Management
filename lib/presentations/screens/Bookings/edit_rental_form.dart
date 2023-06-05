import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/models/guest_kind_model.dart';
import '../../widgets/dialog.dart';

enum Sex { male, female }

String? gender = 'Male';

// ignore: must_be_immutable
class EditForm extends StatefulWidget {
  static final String routeName = 'edit_form';
  RentalFormModel rental;
  EditForm({super.key, required this.rental});

  @override
  State<EditForm> createState() => _EditFormState();
}

class DropDown extends StatefulWidget {
  //static final DropDown _singleton = DropDown._internal();
  String? dropdownKindValue;
  // factory DropDown() {
  //   return _singleton;
  // }

  String selectedValue() {
    return dropdownKindValue!;
  }

  DropDown({super.key});
  //DropDown._internal();
  // const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> kindGuestItems = [];
  @override
  Widget build(BuildContext context) {
    kindGuestItems = [];
    kindGuestItems.addAll(GuestKindModel.kindItems);
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        validator: (value) => value == null ? 'field required' : null,
        isExpanded: true,
        decoration: InputDecoration(border: InputBorder.none),

        alignment: Alignment.centerLeft,
        icon: Transform.translate(
            offset: Offset(-10, -4),
            child: Icon(
              FontAwesomeIcons.sortDown,
              size: 16,
            )),
        // iconStyleData:
        //     IconStyleData(iconEnabledColor: ColorPalette.primaryColor),
        // dropdownStyleData: DropdownStyleData(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(kMinPadding))),

        hint: Text(
          'Choose here',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.grayText.copyWith(fontSize: 12).italic,
        ),

        items: kindGuestItems
            .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: TextStyles.defaultStyle,
                )))
            .toList(),
        // buttonStyleData: const ButtonStyleData(
        //   padding: const EdgeInsets.only(left: 12),
        // ),
        // menuItemStyleData: const MenuItemStyleData(),
        value: widget.dropdownKindValue,

        onChanged: (value) {
          setState(() {
            widget.dropdownKindValue = value;
          });
        },
      ),
    );
  }
}

class _EditFormState extends State<EditForm> {
  bool isPressed = false;
  int currentId = 0;
  DateTime? _selectedDay;
  List<String> list = [];

  bool isErrorGuest = false;
  bool isErrorDate = false;

  final formKey = GlobalKey<FormState>();
  List<String> listKind = [];
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color(0xffD9D9D9);
    }
    return Color(0xffD9D9D9);
  }

  final typeGuest = ['Domestic', 'Foreign'];
  String roomIDSelected = '';
  List<String> AvailableRoomID = [];
  late RentalFormModel rental;
  late RoomModel room;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.rental.BeginDate;

    try {
      roomIDSelected = widget.rental.RoomID;
      rental = widget.rental;
      room = RoomModel.AllRooms.where(
          (element) => element.roomID == widget.rental.RoomID).first;
      for (String guestID in rental.GuestIDs) {
        GuestModel guest =
            GuestModel.AllGuests.where((element) => element.guestID == guestID)
                .first;
        if (rental.Status == "Paid") {
          RenTailPaidGuestInformation(guest);
        } else {
          RenTailUnPaidGuestInformation(guest);
        }
      }
    } catch (e) {}
  }

  String? dropdownKindValue;
  void addGuest() {
    //
    // DropDown._singleton.resetValue();
    // setState(() {
    TextEditingController _nameGuestController = TextEditingController();
    TextEditingController _cardIdGuestController = TextEditingController();
    TextEditingController _addressGuestController = TextEditingController();
    DropDown dropDown = new DropDown();
    int currentIndex = listRow.length;

    listRow.add(TableRow(children: [
      Container(),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: dropDown,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Name is invalid!";
            } else
              return null;
          },
          controller: _nameGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (!RegExp(r'^[0-9]').hasMatch(value!) ||
                checkGuestID(value) >= 2) {
              return "Id is invalid!";
            } else {
              return null;
            }
          },
          controller: _cardIdGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Address is invalid!";
            }
          },
          controller: _addressGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Container(
        child: GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            UpdateDeleteRow(currentIndex);
          },
        ),
      )
    ]));
    // }
    // );
    for (int i = 1; i < listRow.length; i++) {
      setState(() {
        currentIndex = i;
      });
      listRow[i].children![0] = Container(
        alignment: Alignment.center,
        child: Text('${currentIndex}'),
      );
    }
  }

  void RenTailUnPaidGuestInformation(GuestModel guest) {
    //
    // DropDown._singleton.resetValue();
    // setState(() {
    TextEditingController _nameGuestController = TextEditingController();
    TextEditingController _cardIdGuestController = TextEditingController();
    TextEditingController _addressGuestController = TextEditingController();
    _nameGuestController.text = guest.name;
    _cardIdGuestController.text = guest.guestID;
    _addressGuestController.text = guest.address;

    DropDown dropDown = new DropDown();
    int currentIndex = listRow.length;
    try {
      dropDown.dropdownKindValue = GuestKindModel.AllGuestKinds.where(
          (element) => element.GuestKindID == guest.guestKindID).first.Name;
    } catch (e) {
      dropDown.dropdownKindValue = "";
    }

    listRow.add(TableRow(children: [
      Container(),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: dropDown,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Name is invalid!";
            } else
              return null;
          },
          controller: _nameGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if (!RegExp(r'^[0-9]').hasMatch(value!) ||
                checkGuestID(value) >= 2) {
              return "Id is invalid!";
            } else {
              return null;
            }
          },
          controller: _cardIdGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Address is invalid!";
            }
          },
          controller: _addressGuestController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type here',
              hintStyle: TextStyles.defaultStyle.grayText.italic),
        ),
      ),
      Container(
        child: GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            UpdateDeleteRow(currentIndex);
          },
        ),
      )
    ]));
    // }
    // );
    for (int i = 1; i < listRow.length; i++) {
      setState(() {
        currentIndex = i;
      });
      listRow[i].children![0] = Container(
        alignment: Alignment.center,
        child: Text('${currentIndex}'),
      );
    }
  }

  void RenTailPaidGuestInformation(GuestModel guest) {
    //
    // DropDown._singleton.resetValue();
    // setState(() {
    int currentIndex = listRow.length;
    String GuestKindName = "";
    try {
      GuestKindName = GuestKindModel.AllGuestKinds.where(
          (element) => element.GuestKindID == guest.guestKindID).first.Name;
    } catch (e) {
      GuestKindName = "";
    }
    listRow.add(TableRow(children: [
      Container(),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(GuestKindName),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Text(guest.name)),
      Padding(
          padding: const EdgeInsets.only(left: 8), child: Text(guest.guestID)),
      Padding(
          padding: const EdgeInsets.only(left: 8), child: Text(guest.address)),
      Container(
        child: GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            // UpdateDeleteRow(currentIndex);
          },
        ),
      )
    ]));
    // }
    // );
    for (int i = 1; i < listRow.length; i++) {
      setState(() {
        currentIndex = i;
      });
      listRow[i].children[0] = Container(
        alignment: Alignment.center,
        child: Text('${currentIndex}'),
      );
    }
  }

  List<TableRow> listRow = [
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
          'Type',
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
          'Name',
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
          'ID card',
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
          'Address',
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
              color: ColorPalette.primaryColor, fontWeight: FontWeight.w500),
        ),
      ),
      Container()
    ]),
  ];
  void UpdateDeleteRow(int index) {
    setState(() {
      print(index);
      listRow.removeAt(index);
      for (int i = 1; i < listRow.length; i++) {
        listRow[i].children![0] = Container(
          alignment: Alignment.center,
          child: Text('${i}'),
        );
        listRow[i].children![5] = GestureDetector(
          child: Container(alignment: Alignment.center, child: Text('X')),
          onTap: () {
            UpdateDeleteRow(i);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: kMaxPadding * 1.5,
          backgroundColor: ColorPalette.primaryColor.withOpacity(0.75),
          leading: InkWell(
            customBorder: CircleBorder(),
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
            child: Text('RENTAL FORM', style: TextStyles.h8),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          //       padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              StreamBuilder(
                  stream: FireBaseDataBase.readGuestKinds(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      GuestKindModel.kindItems.clear();

                      GuestKindModel.AllGuestKinds = snapshot.data!;
                      for (GuestKindModel k in GuestKindModel.AllGuestKinds) {
                        GuestKindModel.kindItems.add(k.Name);
                      }
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
              StreamBuilder(
                  stream: FireBaseDataBase.readRooms(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      RoomModel.AllRooms = snapshot.data!;
                      try {
                        rental = RentalFormModel.AllRentalFormModels.where(
                            (element) =>
                                element.RentalID == rental.RentalID).first;
                      } catch (e) {}
                    }
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Room ID',
                                    style: TextStyles.h8.copyWith(
                                        fontSize: 12,
                                        color: ColorPalette.darkBlueText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  height: kDefaultIconSize * 2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.grey)),
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      child: DropdownButton2(
                                        alignment: Alignment.centerLeft,
                                        iconStyleData: IconStyleData(
                                            iconEnabledColor:
                                                ColorPalette.primaryColor),
                                        dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kMinPadding))),
                                        hint: Text(
                                          rental.RoomID,
                                          style:
                                              TextStyles.defaultStyle.grayText,
                                        ),
                                        items: AvailableRoomID.map(
                                            (e) => DropdownMenuItem<String>(
                                                value: e,
                                                onTap: () {
                                                  setState(() {
                                                    roomIDSelected = e;
                                                    room = RoomModel.AllRooms
                                                            .where((element) =>
                                                                element
                                                                    .roomID ==
                                                                roomIDSelected)
                                                        .first;
                                                  });
                                                },
                                                child: Text(
                                                  e,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyles
                                                      .defaultStyle.grayText,
                                                ))).toList(),
                                        buttonStyleData: const ButtonStyleData(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          height: 28,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 28,
                                        ),
                                        value: dropdownKindValue,
                                        onChanged: (value) {
                                          setState(() {
                                            dropdownKindValue = value;
                                            print(dropdownKindValue);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: kMaxPadding,
                                      vertical: kItemPadding),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'All guest',
                                    style: TextStyles.h8.copyWith(
                                        fontSize: 14,
                                        color: ColorPalette.darkBlueText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
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
                                        4: FixedColumnWidth(160),
                                        5: FixedColumnWidth(50)
                                      },
                                      children: listRow),
                                ),
                                rental.Status == "Paid"
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          if (listRow.length <=
                                              (room.maxCapacity ?? 1)) {
                                            addGuest();
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogOverlay(
                                                    isSuccess: false,
                                                    task: 'Add Guests',
                                                    error:
                                                        'Exceed the maximum capacity!',
                                                  );
                                                });
                                          }
                                        },
                                        child: Container(
                                          height: kMediumPadding * 1.5,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      color:
                                                          ColorPalette.grayText,
                                                      width: 1),
                                                  right: BorderSide(
                                                      color:
                                                          ColorPalette.grayText,
                                                      width: 1),
                                                  top: BorderSide(
                                                      color:
                                                          ColorPalette.grayText,
                                                      width: 1),
                                                  bottom: BorderSide(
                                                      color:
                                                          ColorPalette.grayText,
                                                      width: 1)),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4))),
                                          child: Icon(
                                            FontAwesomeIcons.plus,
                                            color: ColorPalette.primaryColor,
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Dates',
                                    style: TextStyles.h8.copyWith(
                                        fontSize: 14,
                                        color: ColorPalette.darkBlueText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorPalette.calendarGround
                                            .withOpacity(0.04),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TableCalendar(
                                      focusedDay:
                                          _selectedDay ?? DateTime.now(),
                                      firstDay: DateTime(2010),
                                      lastDay: DateTime(2030),
                                      startingDayOfWeek:
                                          StartingDayOfWeek.monday,
                                      headerStyle: HeaderStyle(
                                        titleCentered: true,
                                        formatButtonVisible: false,
                                      ),
                                      calendarStyle: CalendarStyle(
                                        selectedDecoration: BoxDecoration(
                                            color: ColorPalette.primaryColor,
                                            shape: BoxShape.circle),
                                        selectedTextStyle:
                                            TextStyle(color: Colors.white),
                                        withinRangeDecoration: BoxDecoration(
                                          color: ColorPalette.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        rangeHighlightColor:
                                            ColorPalette.primaryColor,
                                        withinRangeTextStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                      selectedDayPredicate: (day) =>
                                          isSameDay(_selectedDay, day),
                                      onDaySelected: (selectedDay, focusedDay) {
                                        if (rental.Status != 'Paid') if (!isSameDay(
                                            _selectedDay, selectedDay)) {
                                          setState(() {
                                            _selectedDay = selectedDay;
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
                                Visibility(
                                    visible: isErrorDate,
                                    child: Text(
                                      'Please choose days!',
                                      style: TextStyles.defaultStyle
                                          .copyWith(color: Colors.red),
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Unit Price per night',
                                    style: TextStyles.h8.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: ColorPalette.darkBlueText),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${RoomKindModel.getRoomKindPrice(room?.RoomKindID ?? '')} VND',
                                    style: TextStyles.h8.copyWith(
                                        color: ColorPalette.greenText,
                                        fontSize: 12,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                rental.Status == "Paid"
                                    ? Container()
                                    : Material(
                                        color: ColorPalette.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          splashColor: Colors.black38,
                                          onTap: () {
                                            editRoom();
                                          },
                                          child: Container(
                                            width: size.width / 3,
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Edit',
                                              style: TextStyles.h8.copyWith(
                                                  color: ColorPalette
                                                      .backgroundColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 50)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  void changeStateRoom() {
    try {
      CollectionReference roomCollection =
          FirebaseFirestore.instance.collection('Rooms');
      FirebaseFirestore.instance
          .collection('Rooms')
          .where("roomID", isEqualTo: '${rental.RoomID}')
          .get()
          .then((value) {
        DocumentReference document = roomCollection.doc(value.docs[0].id);
        document.update({"State": "Booked"});
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Edit Rental Form ${rental.RentalID} Failed',
              error: e.toString(),
            );
          });
    }
  }

  Future addEditForm() async {
    try {
      DocumentReference doc = FirebaseFirestore.instance
          .collection('RentalForm')
          .doc(rental.RentalID);
      RentalFormModel ren = new RentalFormModel(
          RoomID: roomIDSelected,
          BeginDate: _selectedDay ?? DateTime.now(),
          GuestIDs: list,
          RentalID: rental.RentalID,
          Status: 'Unpaid',
          SurchargeRatio: 0,
          NumberGuestBeginSubCharge: 0,
          HighestGuestKindRatioName: '',
          UnitPrice: 0,
          HighestGuestKindSurchargeRatio: 0);
      await ren.UpdateInformation();
      await doc.set(ren.toJson());
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Edit Rental Form ${rental.RentalID} Failed',
              error: e.toString(),
            );
          });
    }
  }

  Future addNewGuest() async {
    try {
      for (int i = 1; i < listRow.length; i++) {
        Padding padding1 = (listRow[i].children![2]) as Padding;
        Padding padding2 = (listRow[i].children![3]) as Padding;
        Padding padding3 = (listRow[i].children![1]) as Padding;
        Padding padding4 = (listRow[i].children![4]) as Padding;
        TextFormField nameGuest = padding1.child as TextFormField;
        TextFormField cartIdGuest = padding2.child as TextFormField;
        TextFormField addressGuest = padding4.child as TextFormField;
        DropDown typeGuest = padding3.child as DropDown;

        GuestModel guest = new GuestModel(
            guestID: cartIdGuest.controller!.text,
            name: nameGuest.controller!.text,
            guestKindID:
                GuestKindModel.getGuestKindID(typeGuest.selectedValue()),
            address: addressGuest.controller!.text);
        final Json = guest.toJson();
        await FirebaseFirestore.instance
            .collection(GuestModel.CollectionName)
            .doc(cartIdGuest.controller!.text)
            .set(Json);
        list.add(cartIdGuest.controller!.text);
      }
      return 1;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Edit Rental Form ${rental.RentalID} Failed',
              error: e.toString(),
            );
          });
      return 0;
    }
  }

  void editRoom() async {
    print(listRow.length);
    if (listRow.length == 1) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Edit Rental Form ${rental.RentalID}',
              error: 'Guests can not Empty!!!',
            );
          });
    } else if (formKey.currentState!.validate() && _selectedDay != null) {
      list.clear();
      await addNewGuest();
      await addEditForm();
      changeStateRoom();
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: true,
              task: 'Edit Rental Form ${rental.RentalID}',
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Edit Rental Form ${rental.RentalID} Failed',
              error: 'Check Information, please!!!',
            );
          });
      if (_selectedDay == null) {
        setState(() {
          isErrorDate = true;
        });
      }
    }
  }

  void ResetView() {
    setState(() {
      listRow = [
        TableRow(children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'No',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Type',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Name',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'ID card',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'Address',
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                  color: ColorPalette.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ];
    });
  }

  int checkGuestID(String value) {
    int result = 0;
    for (int i = 1; i < listRow.length; i++) {
      Padding padding = (listRow[i].children![3]) as Padding;
      TextFormField cartIdGuest = padding.child as TextFormField;
      if (cartIdGuest.controller!.text == value) result++;
    }
    return result;
  }
}
