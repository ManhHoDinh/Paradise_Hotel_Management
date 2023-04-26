import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:paradise/presentations/widgets/input_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kMaxPadding * 4),
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
                      style: TextStyles.h1.setColor(ColorPalette.darkBlueText)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMaxPadding, vertical: kItemPadding),
                  child: InputWidget(
                    labelText: 'User name',
                    icon: AssetHelper.icoUser,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMaxPadding, vertical: kItemPadding),
                  child: InputWidget(
                    isPassword: true,
                    labelText: 'Password',
                    icon: AssetHelper.icoLock,
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
                    onTap: () {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
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
                        onPressed: () {},
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
                    style: TextStyles.h6.bold.setColor(ColorPalette.greenText),
                  ),
                ),
              ],
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
