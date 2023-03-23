import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/assets_helper.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/presentations/widgets/button_widget.dart';
import 'package:paradise/presentations/widgets/input_widget.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48 * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AssetHelper.icoLogin,),
              Text('Login',
                style: TextStyles.h1.setColor(ColorPalette.blueText)
              ),
              InputWidget(title: 'User name',
                icon: AssetHelper.icoUser,
              ),
              InputWidget(title: 'Password', 
                icon: AssetHelper.icoLock,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      print('object');
                    },
                    icon: Image.asset(AssetHelper.icoSquareBlank),
                  ),
                  Text('Remember me',
                    style: TextStyles.h6
                                     .italic
                                     .setColor(ColorPalette.greenColor),
                  ),
                ],
              ),
              ButtonWidget(label: 'Log in',
                color: ColorPalette.greenColor,
                onTap: () {
                  print('object');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Don'"'"'t have account?',
                      style: TextStyles.h6,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      child: Text('Register',
                        style: TextStyles.h6.setColor(ColorPalette.greenText),
                      ),
                      onPressed: () {
                      
                      },
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  print('object');
                }, 
                child: Text('Forgot password?',
                  style: TextStyles.h6
                                   .light
                                   .setColor(ColorPalette.greenText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}