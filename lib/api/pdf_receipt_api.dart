import 'dart:io';

import 'package:paradise/api/pdf_api.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:pdf/widgets.dart';

class PdfReceiptApi {
  static Future<File> generate(
    ReceiptModel receipt
  ) async {
    final pdf = Document();
    pdf.addPage(MultiPage(build: (context) {
      return [
        buildTile(),
        SizedBox(height: kDefaultPadding),
        buildPaymentGuest(receipt),
      ];
    }));

    return PdfApi.saveDocument(name: '${receipt.receiptID}.pdf', pdf: pdf);
  }

  static Widget buildTotal(
    ReceiptModel receipt
  ) {
    return Container();
  }

  static Widget buildReceiptDetails(

  ) {
    return Container();
  }

  static Widget buildPaymentGuest(
    ReceiptModel receipt
  ) {
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
          //   child: Icon(
          //     FontAwesomeIcons.phone,
          //     color: ColorPalette.primaryColor,
          //     size: 13,
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
            ),
            child: Text(
              '${receipt.phoneNumber}',
              style: TextStyle(fontSize: 20)
            ),
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
      )
    );
  }
}