import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/screens/Onboardings/login_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/register_form_screen.dart';

import '../../../core/constants/color_palatte.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/input_widget.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  static final String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 160,
            ),
            Image.asset(AssetHelper.registerLogo),
            SizedBox(
              height: 30,
            ),
            Text('Register',
                style: TextStyles.h1.setColor(ColorPalette.darkBlueText)),
            SizedBox(
              height: 2 * kMediumPadding,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kMaxPadding),
              child: InputWidget(
                labelText: 'Phone number',
                type: TextInputType.number,
                icon: AssetHelper.icoUser,
                controller: _controller,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMaxPadding, vertical: kMaxPadding),
              child: ButtonWidget(
                label: 'Register',
                color: ColorPalette.primaryColor,
                onTap: () {
                  // ScaffoldMessenger.of(context)
                  // .showSnackBar(SnackBar(content: Text(_controller.text)));
                  verifyPhoneNumber(_controller.text.trim());
                  Navigator.of(context).pushNamed(OtpScreen.routeName);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    'Already have an account?',
                    style: TextStyles.h6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextButton(
                    child: Text(
                      'Log in',
                      style:
                          TextStyles.h6.bold.setColor(ColorPalette.greenText),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';
        verificationID = verificationId;
        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // // Sign the user in (or link) with the credential
        // await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }
}
