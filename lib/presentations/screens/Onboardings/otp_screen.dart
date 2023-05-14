import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:otp_text_field/style.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:otp_text_field/otp_text_field.dart';
import '../../../core/constants/color_palatte.dart';
import '../../../core/helpers/text_styles.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static final String routeName = 'otp_screen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 150),
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(AssetHelper.otpLogo)),
              SizedBox(
                height: 30,
              ),
              Text('Register',
                  style: TextStyles.h1.setColor(ColorPalette.darkBlueText)),
              SizedBox(
                height: 2 * kMediumPadding,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change number',
                  style: TextStyles.defaultStyle.primaryTextColor,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: OTPTextField(
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  length: 6,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
