import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/notification_model.dart';
import 'package:paradise/presentations/widgets/notifi_item.dart';
import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dimension_constants.dart';
import '../../../core/helpers/assets_helper.dart';
import '../../../core/helpers/image_helper.dart';
import '../../../core/helpers/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  static final String routeName = 'notification_screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentId = 2;
  bool _head = false;
  bool _des = false;
  bool manager = true;
  bool staff = false;
  String? _heading;
  String? _description;
  TextEditingController controlhead = TextEditingController();
  TextEditingController controldes = TextEditingController();
  late List<NotificationModel> listNotification;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manager = AuthServices.CurrentUserIsManager();
    staff = !manager;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Notification =
        FirebaseFirestore.instance.collection('Notification');
    Size size = MediaQuery.of(context).size;
    Future<void> addNotification() {
      return Notification.add({
        'heading': controlhead.text,
        'description': controldes.text,
        'postTime': DateTime.now(),
        'postAuthor': AuthServices.CurrentUser!.Name
      }).then((value) => print("New Notification Posted")).catchError(
          (error) => print("Failed to add new notification: $error"));
    }

    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorPalette.backgroundColor,
          title: Padding(
            padding: const EdgeInsets.only(
                left: 100, right: 10, top: 25, bottom: 20),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      ImageHelper.loadFromAsset(AssetHelper.avatar, height: 40)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          // StreamBuilder<int>(
          //                   stream: TotalPriceStream.stream,
          //                   initialData: 0,
          //                   builder: (BuildContext context,
          //                       AsyncSnapshot<int> snapshot) {
          //                     return Text(
          //                       '${NumberFormat.decimalPattern().format(snapshot.data)} VND',
          //                       style: TextStyles.h4.copyWith(
          //                           color: ColorPalette.primaryColor,
          //                           fontWeight: FontWeight.w500),
          //                     );
          //                   },
          //                 )),
          // child: StreamBuilder<bool>(
          //     stream: AuthServices.CurrentUserIsManagerStream.stream,
          //     initialData: false,
          //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          //       if(snapshot.hasData)
          //       {manager = snapshot.data!;
          //       staff = !snapshot.data!;}
          //       return }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: AuthServices.CurrentUserIsManager(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Notification",
                      style: TextStyles.defaultMonth.copyWith(
                        color: ColorPalette.primaryColor,
                        letterSpacing: 1.05,
                      ),
                    ),
                    SizedBox(height: 17),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              color:
                                  ColorPalette.primaryColor.withOpacity(0.75),
                              width: 1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Container(
                              child: SizedBox(
                                height: 42,
                                width: double.infinity,
                                child: TextField(
                                  controller: controlhead,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 4, left: 20),
                                      suffixIcon: InkWell(
                                        customBorder: CircleBorder(),
                                        child: Icon(
                                          FontAwesomeIcons.pen,
                                          color: ColorPalette.primaryColor
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      hintText: 'Heading',
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: ColorPalette.greenText,
                                        fontFamily: AppFonts.inter,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.08,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorPalette.primaryColor,
                                              width: 2))),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _head,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "This box cannot be empty!",
                                style: TextStyles.descriptionRoom.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Container(
                              child: SizedBox(
                                height: 42,
                                width: double.infinity,
                                child: TextField(
                                  controller: controldes,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 4, left: 20),
                                      suffixIcon: InkWell(
                                        customBorder: CircleBorder(),
                                        child: Icon(
                                          FontAwesomeIcons.pen,
                                          color: ColorPalette.primaryColor
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      hintText: 'Description',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: ColorPalette.detailBorder,
                                        fontFamily: AppFonts.inter,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.08,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorPalette.primaryColor,
                                              width: 2))),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _des,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "This box cannot be empty!",
                                style: TextStyles.descriptionRoom.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (controlhead.text != "" &&
                                      controldes.text != "") {
                                    _head = false;
                                    _des = false;
                                    addNotification();
                                    controlhead.text = "";
                                    controldes.text = "";
                                  } else {
                                    if (_heading == null) {
                                      _head = true;
                                    }
                                    if (_description == null) {
                                      _des = true;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 85,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: ColorPalette.primaryColor
                                      .withOpacity(0.75),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  "Save",
                                  style: TextStyles.iconInDetailRoom.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1.08,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 46),
                    Text(
                      "Posted",
                      style: TextStyles.defaultMonth.copyWith(
                        color: ColorPalette.primaryColor,
                        letterSpacing: 1.05,
                      ),
                    ),
                    SizedBox(height: 17),
                  ],
                ),
              ),
              Visibility(
                visible: !AuthServices.CurrentUserIsManager(),
                child: Column(
                  children: [
                    Text(
                      "From Manager",
                      style: TextStyles.defaultMonth.copyWith(
                        color: ColorPalette.primaryColor,
                        letterSpacing: 1.05,
                      ),
                    ),
                    SizedBox(height: 17),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<List<NotificationModel>>(
                    stream: FireBaseDataBase.readNotification(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child:
                              Text('Something went wrong! ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        listNotification = snapshot.data!;
                        NotificationModel.AllNotificationModels =
                            snapshot.data!;
                        listNotification
                            .sort((a, b) => b.postTime.compareTo(a.postTime));
                        return GridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 32,
                            childAspectRatio: 3.15,
                            children: listNotification
                                .map((e) => NotifiItem(
                                      notification: e,
                                    ))
                                .toList());
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
