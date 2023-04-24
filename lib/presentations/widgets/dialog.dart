import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class DialogOverlay extends StatelessWidget {
  final bool isSuccess;
  final String task;
  final String? error;

  const DialogOverlay(
      {super.key, required this.isSuccess, required this.task, this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Image.asset(
        isSuccess ? AssetHelper.icoChecked : AssetHelper.icoCanceled,
        excludeFromSemantics: true,
        height: 120,
      ),
      backgroundColor: Colors.white.withOpacity(0),
      shadowColor: Colors.white.withOpacity(0),
      content: Text(
        isSuccess ? task + ' Successed!' : task + ' Failed!\n' + (error ?? ''),
        textAlign: TextAlign.center,
        style: TextStyles.h5.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
