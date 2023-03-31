import 'package:flutter/material.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class DialogOverlay extends StatelessWidget {
  final bool isSuccess;

  const DialogOverlay({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Image.asset(isSuccess
          ? AssetHelper.icoChecked
          : AssetHelper.icoCanceled,
        excludeFromSemantics: true,
        height: 120,
      ),
      content: Text(isSuccess
          ? 'Create Successfully!'
          : 'Error!\nRoom ID is Exist',
        textAlign: TextAlign.center,
        style: TextStyles.h5.copyWith(
          // color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}