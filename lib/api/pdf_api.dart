import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:path/path.dart' as path;

class PdfApi {
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final result = await FilePicker.platform.getDirectoryPath();
    String? selectedPath;
    final bytes = await pdf.save();

    // // if (result != null) {
    selectedPath = result;
    final file = File(path.join(selectedPath!, name));
    await file.writeAsBytes(bytes);
    return file;
    // }
    // return File("");

    // final dir = await getApplicationDocumentsDirectory();
    // final file = File('${dir.path}/$name');
    // await file.writeAsBytes(bytes);
    // return file;
  }
}
