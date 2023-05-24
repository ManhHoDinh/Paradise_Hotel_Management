import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/image_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

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
    int renDays = checkOutDate.difference(rentalFormModel.BeginDate).inDays;
    if (renDays == 0) renDays = 1;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
            margin: const EdgeInsets.only(top: kDefaultPadding),
            decoration: BoxDecoration(
                color: ColorPalette.primaryColor.withAlpha(50),
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
                      style: TextStyles.h6
                          .copyWith(color: ColorPalette.infoDetail),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kMinPadding),
                    child: Text(
                      'G.K.S',
                      style: TextStyles.h6
                          .copyWith(color: ColorPalette.infoDetail),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                      'E.C.S',
                      style: TextStyles.h6
                          .copyWith(color: ColorPalette.infoDetail),
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
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kMinPadding),
                    width: 60,
                    child: Text(
                      NumberFormat.decimalPattern()
                          .format(rentalFormModel.GuestKindSurcharge(renDays)),
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                  Container(
                    width: 60,
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                      NumberFormat.decimalPattern().format(
                          rentalFormModel.ExcessCustomerSurcharge(renDays)),
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 80,
                    margin: const EdgeInsets.only(
                      top: kDefaultPadding,
                    ),
                    child: Text(
                      NumberFormat.decimalPattern()
                              .format(rentalFormModel.UnitPrice) +
                          ' x',
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: kDefaultPadding * 1.4,
                    ),
                    child: Text(
                      rentalFormModel.HighestGuestKindSurchargeRatio
                              .toString() +
                          ' x',
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                      '1.25 x',
                      style:
                          TextStyles.h6.copyWith(color: ColorPalette.rankText),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    margin: const EdgeInsets.only(top: kMinPadding * 2),
                    child: itemsWithType(
                      image: AssetHelper.icoGuest,
                      counter: rentalFormModel
                          .NumberOfHighestGuestKindRatioSurchargeGuest(),
                      type: rentalFormModel.HighestGuestKindRatioName,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: kMinPadding * 2,
                    ),
                    child: itemsWithType(
                      image: AssetHelper.icoGroup,
                      counter: rentalFormModel.NumberGuestNoSubCharge,
                      type: rentalFormModel.GuestIDs.length.toString(),
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
                    top: kMinPadding, bottom: kDefaultPadding),
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
                    top: kMinPadding, bottom: kDefaultPadding),
                child: Text(
                  '${NumberFormat.decimalPattern().format(rentalFormModel.ExcessCustomerSurcharge(renDays) + rentalFormModel.GuestKindSurcharge(renDays))} VND',
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
                margin: const EdgeInsets.only(bottom: kDefaultPadding),
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
                margin: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  '${NumberFormat.decimalPattern().format(rentalFormModel.Total(renDays))} VND',
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
                    color: ColorPalette.primaryColor.withAlpha(50),
                    borderRadius: kDefaultBorderRadius),
                margin: const EdgeInsets.only(bottom: kMinPadding),
                child: Text(
                  '${rentalFormModel.BeginDate.day} ' +
                      monthToString(rentalFormModel.BeginDate.month) +
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
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: kMinPadding),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          border: Border.all(color: ColorPalette.grayText)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageHelper.loadFromAsset(image, height: 15),
          Flexible(
            child: Container(
              width: 55,
              child: Text(
                type,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyles.h6.copyWith(
                    fontWeight: FontWeight.bold, color: ColorPalette.blackText),
              ),
            ),
          ),
          ImageHelper.loadFromAsset(AssetHelper.icoLineVertical, height: 15),
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
