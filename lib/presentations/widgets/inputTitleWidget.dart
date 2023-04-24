import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/dimension_constants.dart';
import '../../core/helpers/text_styles.dart';
import 'input_default.dart';

class InputTitleWidget extends StatelessWidget {
  InputTitleWidget({super.key, this.controller, this.Title, this.hintInput});
  String? Title = '';
  TextEditingController? controller = new TextEditingController();
  String? hintInput = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Text(
            Title ?? '',
            style: TextStyles.h6.copyWith(
                color: ColorPalette.darkBlueText, fontWeight: FontWeight.w500),
          ),
          margin: const EdgeInsets.only(left: kMaxPadding * 1.5, bottom: 5),
        ),
        Container(
          child: InputDefault(
            labelText: hintInput ?? '',
            controller: controller,
          ),
          margin: const EdgeInsets.symmetric(
              horizontal: kMaxPadding * 1.5, vertical: kItemPadding),
        ),
      ],
    );
  }
}
