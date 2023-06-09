import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/presentations/screens/Staffs/register_form_screen.dart';
import 'package:paradise/presentations/screens/forgot_password_screen.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:paradise/presentations/widgets/input_password.dart';
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

  bool isChecked = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final formSignInKey = GlobalKey<FormState>();
  late SharedPreferences pref;

  bool _passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pref();
  }

  void Pref() async {
    pref = await SharedPreferences.getInstance();
    _emailController.text = pref.getString("email").toString();
    _passwordController.text = pref.getString("password").toString();
  }

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
                        labelText: 'Enter your email',
                        icon: AssetHelper.icoUser,
                        validator: (input) {
                          final bool emailValid = RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(input!);
                          if (input.isEmpty) {
                            return "Please enter username";
                          } else if (!emailValid) {
                            return "Email is not Invalid";
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMaxPadding, vertical: kItemPadding),
                    child: TextFormField(
                      validator: (input) {
                        if (input == "") {
                          return "Please enter your password!";
                        } else if (input != null && input.length <= 6) {
                          return "Password is too short!";
                        } else
                          return null;
                      },
                      obscureText: !_passwordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        labelText: 'Enter your password',
                        labelStyle:
                            TextStyles.h6.setColor(ColorPalette.grayText),
                        contentPadding: const EdgeInsets.only(bottom: 14),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: Container(
                          child: Image.asset(AssetHelper.icoLock),
                          padding: const EdgeInsets.only(right: 16),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 24,
                        ),
                      ),
                    ),
                    // InputWidget(
                    //   controller: _passwordController,
                    //   isPassword: true,
                    //   labelText: 'Password',
                    //   icon: AssetHelper.icoLock,
                    //   validator: (input) {
                    //     if (input == "") {
                    //       return "Please enter your password!";
                    //     } else if (input != null && input.length <= 6) {
                    //       return "Password is too short!";
                    //     } else
                    //       return null;
                    //   },
                    // ),
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
                          if (isChecked) {
                            pref.setString('email', _emailController.text);
                            pref.setString(
                                "password", _passwordController.text);
                          } else {
                            pref.setString('email', "");
                            pref.setString("password", "");
                          }
                          await AuthServices.signinUser(_emailController.text,
                              _passwordController.text, context);

                          // await FirebaseFirestore.instance
                          //     .collection("Users")
                          //     .get()
                          //     .then((value) {
                          //   int check = 0;
                          //   for (var doc in value.docs) {
                          //     if (doc.get("Email") == _emailController.text) {
                          //       check++;
                          //     }
                          //   }
                          //   if (check > 0) {
                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text(
                          //                 'No user Found with this Email')));
                          //   }
                          // });
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordScreen.routeName);
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
