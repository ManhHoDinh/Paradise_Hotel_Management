import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/receipt_model.dart';
import 'package:paradise/core/models/rental_form_model.dart';
import 'package:paradise/presentations/screens/Receipts/RentalFormItem.dart';

class PrintReceipt extends StatelessWidget {
  final ReceiptModel receiptModel;
  const PrintReceipt({
    super.key,
    required this.receiptModel,
  });

  @override
  Widget build(BuildContext context) {
    List<RentalFormModel> forms = [];
    
    return Scaffold(
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
            child: Text('PRINT RECEIPT',
                style: TextStyles.slo.bold.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(3, 6),
                      blurRadius: 6,
                    )
                  ],
                ))),
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: kDefaultPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                    ),
                    child: Text(
                      'Payment guest',
                      style: TextStyles.h5.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          child: Text(
                            receiptModel.guestName!,
                            style: TextStyles.h6.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.darkBlueText),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          child:
                              Image.asset(AssetHelper.icoLocation),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          child: Text(
                            receiptModel.address!,
                            style: TextStyles.h6.copyWith(
                              color: ColorPalette.rankText,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          child: Icon(
                            FontAwesomeIcons.phone,
                            color: ColorPalette.primaryColor,
                            size: 13,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                          ),
                          child: Text(
                            receiptModel.phoneNumber!,
                            style: TextStyles.h6.copyWith(
                              color: ColorPalette.rankText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  bottom: kMinPadding),
              child: Text(
                'Receipt Details',
                style: TextStyles.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.primaryColor,
                ),
              ),
            ),
            StreamBuilder<List<RentalFormModel>>(
              stream: FireBaseDataBase.readRentalForms(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  forms = snapshot.data!;
                  for (int i = 0; i < forms.length; i++) {
                    if (!receiptModel.rentalFormIDs.contains(forms[i].RentalID)) {
                      forms.removeAt(i);
                      i--;
                    }
                  }
        
                  return Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => RentalFormItem(
                          rentalFormModel: forms[index],
                          checkOutDate: receiptModel.checkOutDate!,
                        ),
                        itemCount: forms.length,
                      ),
                    )
                  );
                } else
                  return Container();
              }
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: kMinPadding,
                  bottom: 20),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      'TOTAL',
                      style: TextStyles.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Text(
                      NumberFormat.decimalPattern()
                              .format(receiptModel.total) +
                          ' VND',
                      style: TextStyles.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}