import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/screens/Onboardings/AuthFunctions.dart';
import 'package:paradise/presentations/screens/Onboardings/register_screen.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:paradise/presentations/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/dialog.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorPalette.primaryColor;
    }
    return ColorPalette.primaryColor;
  }

  bool isChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kMaxPadding * 4),
            child: Form(
              key: formSignInKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kItemPadding),
                    child: Image.asset(
                      AssetHelper.icoLogin,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kItemPadding),
                    child: Text('Login',
                        style:
                            TextStyles.h1.setColor(ColorPalette.darkBlueText)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding, vertical: kItemPadding),
                    child: InputWidget(
                        controller: _emailController,
                        labelText: 'User name',
                        icon: AssetHelper.icoUser,
                        validator: (input) {
                          final bool emailValid = RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(input!);
                          if (!emailValid) {
                            return "Email is not Invalid";
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding, vertical: kItemPadding),
                    child: InputWidget(
                      controller: _passwordController,
                      isPassword: true,
                      labelText: 'Password',
                      icon: AssetHelper.icoLock,
                      validator: (input) {
                        if (input != null && input.length <= 6) {
                          return "Password is too short!";
                        } else
                          return null;
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 33, vertical: kItemPadding),
                    child: Row(
                      children: [
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => getColor(states)),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                            );
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyles.h6.italic
                              .setColor(ColorPalette.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding, vertical: kItemPadding),
                    child: ButtonWidget(
                      label: 'Log in',
                      color: ColorPalette.primaryColor,
                      onTap: () async {
                        if (formSignInKey.currentState!.validate()) {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (isChecked) {
                            pref.setString('email', _emailController.text);
                          }
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogOverlay(
                                  isSuccess: true,
                                  task: 'login',
                                );
                              });
                          if (isChecked) {}
                          AuthServices.signinUser(_emailController.text,
                              _passwordController.text, context);
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Don' "'" 't have account?',
                          style: TextStyles.h6,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          child: Text(
                            'Register',
                            style: TextStyles.h6.bold
                                .setColor(ColorPalette.greenText),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      print('object');
                    },
                    child: Text(
                      'Forgot password?',
                      style:
                          TextStyles.h6.bold.setColor(ColorPalette.greenText),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
