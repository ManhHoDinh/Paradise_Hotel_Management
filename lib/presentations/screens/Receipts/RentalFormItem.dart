import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/core/models/guest_model.dart';
import 'package:paradise/core/models/room_kind_model.dart';
import 'package:paradise/core/models/room_model.dart';

import '../../../core/models/rental_form_model.dart';

class RentalFormItem extends StatelessWidget {
  final RentalFormModel rentalFormModel;
  final DateTime checkOutDate;
  const RentalFormItem({
    super.key,
    required this.rentalFormModel,
    required this.checkOutDate,
  });

  @override
  Widget build(BuildContext context) {
    RoomModel room;
    RoomKindModel? roomKind;
    List<GuestModel>? guests;
    int Price = 0, total = 0;
    double ratio = 0;

    int renDays = checkOutDate.difference(rentalFormModel.BeginDate).inDays;

    return StreamBuilder<List<GuestModel>>(
        stream: FireBaseDataBase.readGuests(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            guests = snapshot.data!;
            List<double> ratios = [];

            for (int i = 0; i < guests!.length; i++) {
              if (!rentalFormModel.GuestIDs.contains(guests![i].guestID)) {
                guests!.removeAt(i);
                i--;
              }
            }

            return StreamBuilder<List<GuestKindModel>>(
                stream: FireBaseDataBase.readGuestKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    GuestKindModel.AllGuestKinds = snapshot.data!;
                    for (var element in guests!) {
                      ratios.add(
                          GuestKindModel.getGuestKindRatio(element.guestID));
                    }
                    ratios.sort();
                    ratio = ratios.last;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding),
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: kDefaultBorderRadius,
                          border: Border.all(color: ColorPalette.grayText)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kMinPadding,
                            ),
                            margin:
                                const EdgeInsets.only(
                                  top:  kDefaultPadding),
                            decoration: BoxDecoration(
                                color:
                                    ColorPalette.primaryColor.withAlpha(50),
                                borderRadius: kDefaultBorderRadius),
                            child: Text(
                              rentalFormModel.RentalID,
                              style: TextStyles.h6.copyWith(
                                  color: ColorPalette.darkBlueText,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding,
                                    ),
                                    child: Text(
                                      'R.ID',
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.infoDetail),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding * 3),
                                    child: Text(
                                      'G.K.S',
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.infoDetail),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding * 1.4),
                                    child: Text(
                                      'E.C.S',
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.infoDetail),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding,
                                    ),
                                    child: Text(
                                      rentalFormModel.RoomID,
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.rankText),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding * 3),
                                    child: Text(
                                      '100000',
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.rankText),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding * 1.4),
                                    child: Text(
                                      '100000',
                                      style: TextStyles.h6.copyWith(
                                          color: ColorPalette.rankText),
                                    ),
                                  ),
                                ],
                              ),
                              StreamBuilder<List<RoomModel>>(
                                  stream: FireBaseDataBase.readRooms(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else if (snapshot.hasData) {
                                      List<RoomModel> rooms = snapshot.data!;
                                      room = rooms
                                          .where((element) =>
                                              element.roomID ==
                                              rentalFormModel.RoomID)
                                          .single;

                                      return StreamBuilder<List<RoomKindModel>>(
                                          stream:
                                              FireBaseDataBase.readRoomKinds(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'),
                                              );
                                            } else if (snapshot.hasData) {
                                              List<RoomKindModel> roomKinds =
                                                  snapshot.data!;
                                              roomKind = roomKinds
                                                  .where(
                                                    (element) =>
                                                        element.RoomKindID ==
                                                        room.RoomKindID,
                                                  )
                                                  .single;
                                              Price = roomKind!.Price!;
                                              total = (ratio * Price * renDays)
                                                  .ceil();

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerRight,
                                                    width: 80,
                                                    margin: const EdgeInsets
                                                        .only(
                                                      top: kDefaultPadding,
                                                    ),
                                                    child: Text(
                                                      Price.toString() +
                                                          ' x',
                                                      style: TextStyles.h6
                                                          .copyWith(
                                                              color: ColorPalette
                                                                  .rankText),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.centerRight,
                                                    width: 80,
                                                    margin: const EdgeInsets
                                                        .only(
                                                          top: kDefaultPadding * 1.4
                                                    ),
                                                    child: Text(
                                                      '100000 x',
                                                      style: TextStyles.h6
                                                          .copyWith(
                                                              color: ColorPalette
                                                                  .rankText),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .only(
                                                        top:
                                                            kDefaultPadding * 1.4),
                                                    child: Text(
                                                      ratio.toString() + ' x',
                                                      style: TextStyles.h6
                                                          .copyWith(
                                                              color: ColorPalette
                                                                  .rankText),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .only(
                                                        top:
                                                            kDefaultPadding * 1.4),
                                                    child: Text(
                                                      '1.25 x',
                                                      style: TextStyles.h6
                                                          .copyWith(
                                                              color: ColorPalette
                                                                  .rankText),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else
                                              return Container();
                                          });
                                    } else
                                      return Container();
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: kDefaultPadding - kMinPadding),
                                    child: itemsWithoutType(
                                      image: AssetHelper.icoMoon,
                                      counter: renDays,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: kMinPadding * 2),
                                    child: itemsWithoutType(
                                      image: AssetHelper.icoService,
                                      counter: 1,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: kMinPadding * 2),
                                    child: itemsWithType(
                                      image: AssetHelper.icoGuest,
                                      counter: countForeign(guests),
                                      type: 'A',
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(
                                          vertical: kMinPadding * 2,),
                                    child: itemsWithType(
                                      image: AssetHelper.icoGroup,
                                      counter: countForeign(guests),
                                      type: '1',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: kMinPadding,
                                    bottom: kDefaultPadding),
                                child: Text(
                                  'Total Surcharge',
                                  style: TextStyles.h6.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: ColorPalette.primaryColor),
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    top: kMinPadding,
                                    bottom: kDefaultPadding),
                                child: Text(
                                  '${rentalFormModel.Total(renDays)} VND',
                                  softWrap: true,
                                  style: TextStyles.h5.copyWith(
                                    fontStyle: FontStyle.italic,
                                      color: ColorPalette.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: Text(
                                  'TOTAL',
                                  style: TextStyles.h5.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorPalette.darkBlueText),
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: Text(
                                  '${rentalFormModel.Total(renDays)} VND',
                                  softWrap: true,
                                  style: TextStyles.h5.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: ColorPalette.darkBlueText),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding,
                                  vertical: kMinPadding,
                                ),
                                decoration: BoxDecoration(
                                    color:
                                        ColorPalette.primaryColor.withAlpha(50),
                                    borderRadius: kDefaultBorderRadius),
                                margin:
                                    const EdgeInsets.only(bottom: kMinPadding),
                                child: Text(
                                  '${rentalFormModel.BeginDate.day} ' +
                                      monthToString(
                                          rentalFormModel.BeginDate.month) +
                                      ' - '
                                          '${checkOutDate.day} ' +
                                      monthToString(checkOutDate.month),
                                  style: TextStyles.h6.copyWith(
                                      color: ColorPalette.darkBlueText,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  } else
                    return Container();
                });
          } else
            return Container();
        });
  }

  int countForeign(List<GuestModel>? guests) {
    int counter = 0;

    for (GuestModel guest in guests!) {
      final guestKindName = GuestKindModel.getGuestKindName(guest.guestKindID);
      if (guestKindName == 'Foreign') {
        counter++;
      }
    }

    return counter;
  }

  String monthToString(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  Widget itemsWithoutType({
    required String image,
    required int counter,
  }) {
    return Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: kMinPadding),
      decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          border: Border.all(color: ColorPalette.grayText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageHelper.loadFromAsset(image, height: 15),
          Text(
            counter.toString(),
            style: TextStyles.h6.copyWith(
                fontWeight: FontWeight.bold, color: ColorPalette.blackText),
          )
        ],
      ),
    );
  }
  Widget itemsWithType({
    required String image,
    required int counter,
    required String type,
  }) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: kMinPadding),
      decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          border: Border.all(color: ColorPalette.grayText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageHelper.loadFromAsset(image, height: 15),
          Text(
            type,
            style: TextStyles.h6.copyWith(
                fontWeight: FontWeight.bold, color: ColorPalette.blackText),
          ),
          ImageHelper.loadFromAsset(
            AssetHelper.icoLineVertical,
            height: 15
          ),
          Text(
            counter.toString(),
            style: TextStyles.h6.copyWith(
                fontWeight: FontWeight.bold, color: ColorPalette.blackText),
          )
        ],
      ),
    );
  }
}
