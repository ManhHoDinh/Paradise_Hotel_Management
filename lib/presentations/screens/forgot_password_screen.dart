import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/screens/Onboardings/login_screen.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/helpers/assets_helper.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static final String routeName = 'forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 200,
          ),
          Text(
            'Enter your email to reset your password!',
            style: TextStyles.defaultStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: kMediumPadding,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kMaxPadding, vertical: kItemPadding),
            child: InputWidget(
                controller: _emailController,
                labelText: 'Enter your user name',
                icon: AssetHelper.icoUser,
                validator: (input) {
                  final bool emailValid = RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(input!);
                  if (input == "") {
                    return "Please enter your email!";
                  } else if (!emailValid) {
                    return "Email is invalid";
                  }
                }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kMaxPadding, vertical: kItemPadding),
            child: ButtonWidget(
              label: 'Reset Password',
              color: ColorPalette.primaryColor,
              onTap: resetPassword,
            ),
          ),
        ]),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password reset email sent!')));
      Navigator.popUntil(context, ModalRoute.withName(LoginScreen.routeName));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
