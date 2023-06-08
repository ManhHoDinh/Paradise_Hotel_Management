import 'dart:io';

import 'package:intl/intl.dart';
import 'package:paradise/api/pdf_api.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../core/constants/color_palatte.dart';
import '../core/models/report.dart';

import 'package:pdf/widgets.dart';
//import 'package:flutter/material.dart';

class PdfReportApi {
  static Future<File> generate(
      {required Report report,
      required String year,
      String? month,
      required int total}) async {
    final pdf = Document();
    pdf.addPage(MultiPage(build: (context) {
      return [
        month == null
            ? buildTile(year: year)
            : buildTile(year: year, month: month),
        buildTableReport(report),
        SizedBox(height: kMaxPadding),
        buildToTalPrice(total)
      ];
    }));
    if (month == null) {
      return PdfApi.saveDocument(name: '${year}_report.pdf', pdf: pdf);
    }
    return PdfApi.saveDocument(name: '${month}_${year}_report.pdf', pdf: pdf);
  }

  static Widget buildTile({required String year, String? month}) {
    return Column(children: [
      Text('REPORT',
          style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
      SizedBox(height: kMediumPadding),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, style: BorderStyle.solid)),
          child: Text(month == null ? '$year' : '$month, $year',
              style: TextStyle(fontSize: 20))),
      SizedBox(height: kMaxPadding)
    ]);
  }

  static Widget buildTableReport(Report report) {
    int index = 0;
    return Table.fromTextArray(
        cellAlignment: Alignment.center,
        data: report.items.map((e) {
          index++;
          return [
            '$index',
            '${e.roomType}',
            '${NumberFormat.decimalPattern().format(e.revenue)}',
            '${NumberFormat('#.##', 'en_US').format(e.rate * 100)}%'
          ];
        }).toList(),
        headers: ['No', 'Room Kind', 'Revenue (VND)', 'Rate']);
  }

  static Widget buildToTalPrice(int total) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text('TOTAL', style: TextStyle(fontSize: 24)),
      SizedBox(width: kMaxPadding),
      Text('${NumberFormat.decimalPattern().format(total)} VND',
          style: TextStyle(fontSize: 24))
    ]);
  }
}
