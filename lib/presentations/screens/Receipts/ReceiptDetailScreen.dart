import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:paradise/api/pdf_api.dart';
import 'package:paradise/api/pdf_receipt_api.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/presentations/screens/Receipts/PrintReceipt.dart';
import 'package:paradise/presentations/screens/Receipts/RentalFormItem.dart';
import 'package:paradise/presentations/widgets/button_default.dart';
import 'package:paradise/presentations/widgets/dialog.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../core/models/receipt_model.dart';
import '../../../core/models/rental_form_model.dart';
import 'package:path/path.dart' as path;

class ReceiptDetailScreen extends StatefulWidget {
  final ReceiptModel Receipt;
  const ReceiptDetailScreen({
    super.key,
    required this.Receipt,
    // required this.receiptModel,
  });

  @override
  State<ReceiptDetailScreen> createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  int currentId = 0;
  bool isLoading = false;
  List<RentalFormModel> forms = [];
  late ReceiptModel receiptModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiptModel = widget.Receipt;
  }

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            'RECEIPT DETAIL',
            style: TextStyles.h8.bold.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(3, 6),
                  blurRadius: 6,
                )
              ],
              letterSpacing: 1.175,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: ColorPalette.primaryColor,
                size: 100,
              ),
            )
          : StreamBuilder<List<RentalFormModel>>(
              stream: FireBaseDataBase.readRentalForms(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  forms = snapshot.data!;
                  for (int i = 0; i < forms.length; i++) {
                    if (!receiptModel.rentalFormIDs
                        .contains(forms[i].RentalID)) {
                      forms.removeAt(i);
                      i--;
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            // horizontal: kDefaultPadding * 1.5,
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
                                // height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: kDefaultBorderRadius,
                                    border: Border.all(
                                        color: ColorPalette.grayText)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding,
                                        vertical: kDefaultPadding,
                                      ),
                                      child: Text(
                                        receiptModel.guestName!,
                                        style: TextStyles.h6.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: ColorPalette.darkBlueText),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: kDefaultPadding,
                                            // right: kDefaultPadding,
                                            bottom: kDefaultPadding,
                                          ),
                                          child: Image.asset(
                                              AssetHelper.icoLocation),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: kDefaultPadding,
                                            right: kDefaultPadding,
                                            bottom: kDefaultPadding,
                                          ),
                                          child: Text(
                                            receiptModel.address!,
                                            style: TextStyles.h6.copyWith(
                                              color: ColorPalette.rankText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          margin: const EdgeInsets.only(
                                            left: kDefaultPadding,
                                            // right: kDefaultPadding,
                                            bottom: kDefaultPadding,
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.phone,
                                            color: ColorPalette.primaryColor,
                                            size: 13,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: kDefaultPadding,
                                            right: kDefaultPadding,
                                            bottom: kDefaultPadding,
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              // horizontal: kDefaultPadding * 1.5,
                              bottom: 20),
                          child: Text(
                            'Receipt Details',
                            style: TextStyles.h5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.primaryColor,
                            ),
                          ),
                        ),
                        Container(
                            child: Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => RentalFormItem(
                              rentalFormModel: forms[index],
                              checkOutDate: receiptModel.checkOutDate!,
                            ),
                            itemCount: forms.length,
                          ),
                        )),
                        Container(
                          margin: const EdgeInsets.only(
                              // horizontal: kDefaultPadding * 1.5,
                              top: 20),
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
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: kMaxPadding * 2,
                            vertical: kDefaultPadding,
                          ),
                          child: ButtonDefault(
                            label: 'Print Receipt',
                            onTap: () async {
                              final pdfFile = await PdfReceiptApi.generate(
                                  receiptModel, forms);

                              PdfApi.openFile(pdfFile);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else
                  return Container();
              }),
    );
  }

  Future<void> generatePDF() async {
    PdfDocument document = PdfDocument();
    var page = document.pages.add();
    page.graphics
        .drawString('binh day', PdfStandardFont(PdfFontFamily.helvetica, 30));

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
