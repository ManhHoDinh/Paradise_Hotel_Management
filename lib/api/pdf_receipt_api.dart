import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:paradise/api/pdf_api.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

class PdfReceiptApi {
  static Future<File> generate(
      ReceiptModel receipt, List<RentalFormModel> forms) async {
    final pdf = Document();
    pdf.addPage(MultiPage(build: (context) {
      return [
        buildTile(),
        SizedBox(height: kDefaultPadding),
        Text('Booking Details', style: TextStyle(fontSize: 24)),
        SizedBox(height: kDefaultPadding),
        buildPaymentGuest(receipt),
        Text('Receipt Details', style: TextStyle(fontSize: 24)),
        SizedBox(height: kDefaultPadding),
        buildTableReceipt(receipt, forms),
        SizedBox(height: kDefaultPadding),
        Container(
          child: Row(
            children: [
              Container(
                child: Text('TOTAL', style: TextStyle(fontSize: 24)),
              ),
              Spacer(),
              Container(
                child: Text(
                    '${NumberFormat.decimalPattern().format(receipt.total)} ' +
                        ' VND',
                    style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ];
    }));

    return PdfApi.saveDocument(name: '${receipt.receiptID}s3fd.pdf', pdf: pdf);
  }

  static Widget buildTotal(ReceiptModel receipt) {
    return Container();
  }

  static Widget buildReceiptDetails() {
    return Container();
  }

  static Widget buildPaymentGuest(ReceiptModel receipt) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child: Text(
              '${receipt.guestName}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(
          //     vertical: kDefaultPadding,
          //   ),
          //   child:
          //       Image.asset(AssetHelper.icoLocation),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child: Text(
              '${receipt.address}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Container(
          //   height: 20,
          //   margin: const EdgeInsets.symmetric(
          //     vertical: kDefaultPadding,
          //   ),
          //   child: Image(ImageImage(PdfImage.file(pdf, bytes: )))
          // ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child:
                Text('${receipt.phoneNumber}', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  static Widget buildTile() {
    return Center(
        child: Text(
      'RECEIPT',
      style: TextStyle(
        fontSize: 30,
      ),
      textAlign: TextAlign.center,
    ));
  }

  static Widget rentalFormPdf(
      ReceiptModel receiptModel, RentalFormModel rentalFormModel) {
    int renDays =
        receiptModel.checkOutDate!.difference(rentalFormModel.BeginDate).inDays;
    var inforReceipt = [
      [
        'R.ID',
        rentalFormModel.RoomID,
        '${rentalFormModel.UnitPrice} x $renDays',
      ],
      [
        'G.K.S',
        rentalFormModel.GuestKindSurcharge(renDays),
        '${rentalFormModel.HighestGuestKindSurchargeRatio} x ${rentalFormModel.NumberOfHighestGuestKindRatioSurchargeGuest()}',
      ],
      [
        'E.C.S',
        rentalFormModel.ExcessCustomerSurcharge(renDays),
        '1.25 x ${rentalFormModel.NumberGuestBeginSubCharge}',
      ]
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kItemPadding),
      padding: const EdgeInsets.symmetric(horizontal: kItemPadding),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kMinPadding,
            ),
            margin: const EdgeInsets.only(top: kDefaultPadding),
            decoration: BoxDecoration(),
            // borderRadius: kDefaultBorderRadius),
            child: Text(
              rentalFormModel.RentalID,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
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
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kMinPadding),
                    child: Text(
                      'G.K.S',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                      'E.C.S',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    margin: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                    ),
                    child: Text(
                      style: TextStyle(fontSize: 18),
                      rentalFormModel.RoomID,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: kMinPadding),
                    width: 70,
                    child: Text(
                      style: TextStyle(fontSize: 18),
                      '${rentalFormModel.GuestKindSurcharge(renDays)}',
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                        style: TextStyle(fontSize: 18),
                        '${rentalFormModel.ExcessCustomerSurcharge(renDays)}'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: kDefaultPadding,
                    ),
                    child: Text(
                      style: TextStyle(fontSize: 18),
                      '${rentalFormModel.UnitPrice}' +
                          ' x ' +
                          renDays.toString(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: kDefaultPadding * 1.4,
                    ),
                    child: Text(
                      rentalFormModel.HighestGuestKindSurchargeRatio
                              .toString() +
                          ' x ' +
                          '${rentalFormModel.NumberOfHighestGuestKindRatioSurchargeGuest()}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.4),
                    child: Text(
                      '1.25 x ' +
                          '${rentalFormModel.NumberGuestBeginSubCharge}',
                      style: TextStyle(fontSize: 18),
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                    top: kMinPadding, bottom: kDefaultPadding),
                child: Text(
                  style: TextStyle(fontSize: 18),
                  '${rentalFormModel.ExcessCustomerSurcharge(renDays) + rentalFormModel.GuestKindSurcharge(renDays)} VND',
                  softWrap: true,
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
                  style: TextStyle(fontSize: 20),
                  'TOTAL',
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  style: TextStyle(fontSize: 20),
                  '${rentalFormModel.Total(renDays)} VND',
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // return Table.fromTextArray(
    //     data: inforReceipt,
    //     headers: [' ', '${rentalFormModel.RentalID}', ' '],
    //     headerAlignment: Alignment.centerLeft,
    //     border: TableBorder(left: BorderSide.none));
  }

  static Widget buildTableReceipt(
      ReceiptModel receiptModel, List<RentalFormModel> forms) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            rentalFormPdf(receiptModel, forms[index]),
        itemCount: forms.length);
  }
}
