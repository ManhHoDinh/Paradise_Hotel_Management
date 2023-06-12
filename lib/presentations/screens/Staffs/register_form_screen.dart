import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/presentations/screens/Onboardings/home_screen.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/dialog.dart';

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});
  static final String routeName = "register_form";

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final formRegisterKey = GlobalKey<FormState>();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cccdControler = TextEditingController();
  bool isAccept = false;
  bool _passwordVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> kindItems = ['Manager', 'Staff'];
  String dropdownKindValue = 'Manager';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPalette.primaryColor,
        leadingWidth: kDefaultIconSize * 3,
        leading: Container(
          width: double.infinity,
          child: InkWell(
            customBorder: CircleBorder(),
            onHighlightChanged: (param) {},
            splashColor: ColorPalette.primaryColor,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(FontAwesomeIcons.arrowLeft),
            ),
          ),
        ),
        title: Container(
            child: Text('CREATE USER',
                style: TextStyles.slo.bold.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(3, 6),
                      blurRadius: 6,
                    )
                  ],
                ))),
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60),
          margin: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          child: Form(
            key: formRegisterKey,
            child: Column(children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  final bool emailValid = RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(input!);
                  if (input == "") {
                    return "Please enter your email!";
                  } else if (!emailValid) {
                    return "Email is not Invalid";
                  }
                },
                controller: _emailController,
                decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(kMediumPadding))),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Please enter your phone number!";
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value) ||
                      value.length < 10) {
                    return "Phone number is invalid!";
                  } else
                    return null;
                },
                controller: _phoneNoController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Phone number',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(kMediumPadding))),
              ),

              // IntlPhoneField(
              //   controller: _phoneNoController,
              //   decoration: InputDecoration(
              //     isDense: true,
              //     labelText: 'Phone Number',
              //     labelStyle:
              //         TextStyle(fontSize: 14, color: ColorPalette.primaryColor),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide:
              //           BorderSide(color: ColorPalette.primaryColor, width: 2),
              //       borderRadius: BorderRadius.circular(kMediumPadding),
              //     ),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.transparent),
              //       borderRadius: BorderRadius.circular(kMediumPadding),
              //     ),
              //   ),
              //   keyboardType: TextInputType.number,
              //   onChanged: (phone) {
              //     print(phone.completeNumber);
              //   },
              //   onCountryChanged: (country) {
              //     print('Country changed to: ' + country.name);
              //   },
              // ),

              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Identification number is invalid!";
                  } else
                    return null;
                },
                controller: _cccdControler,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Identification Numnber',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(kMediumPadding))),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || RegExp(r'^[1 9]+$').hasMatch(value)) {
                    return "Name is invalid!";
                  } else
                    return null;
                },
                controller: _nameController,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Full Name',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(kMediumPadding))),
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return "Birthday is invalid!";
                  } else
                    return null;
                },
                controller: _birthdayController,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Birthday',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(
                            kMediumPadding)) //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);

                    setState(() {
                      _birthdayController.text = formattedDate;
                    }); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    // setState(() {
                    //    dateinput.text = formattedDate; //set output date to TextFormField value.
                    // });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              SizedBox(
                height: kMediumPadding,
              ),
              TextFormField(
                validator: (input) {
                  if (input != null && input.length <= 6) {
                    return "Password is too short!";
                  } else
                    return null;
                },
                controller: _passwordController,
                obscureText: !_passwordVisible,
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
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Account password',
                    labelStyle: TextStyle(
                        color: ColorPalette.primaryColor, fontSize: 14),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(kMediumPadding)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(kMediumPadding))),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.primaryColor),
                    borderRadius: BorderRadius.circular(kMediumPadding)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    alignment: Alignment.center,
                    iconStyleData: IconStyleData(
                        iconEnabledColor: ColorPalette.primaryColor),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMinPadding))),
                    hint: Center(
                      child: Text(
                        'Position',
                        style: TextStyles.defaultStyle.grayText,
                      ),
                    ),
                    items: kindItems
                        .map((e) => DropdownMenuItem<String>(
                            value: e,
                            onTap: () {
                              setState(() {
                                dropdownKindValue = e;
                              });
                            },
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.defaultStyle.primaryTextColor
                                  .copyWith(fontSize: 14),
                            )))
                        .toList(),
                    buttonStyleData: const ButtonStyleData(
                      padding: const EdgeInsets.only(left: 12),
                      height: 28,
                      width: 10,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 28,
                    ),
                    value: dropdownKindValue,
                    onChanged: (value) {
                      setState(() {
                        dropdownKindValue = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: kMediumPadding + 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Material(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.black38,
                    onTap: () {
                      if (formRegisterKey.currentState!.validate()) {
                        AuthServices.signUpUser(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                            _phoneNoController.text,
                            _birthdayController.text,
                            _cccdControler.text,
                            dropdownKindValue,
                            context);

                        // FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: _emailController.text,
                        //         password: _passwordController.text)
                        //     .then((value) => Navigator.of(context)
                        //         .pushNamed(HomeScreen.routeName))
                        //     .onError((error, stackTrace) {
                        //   print("error");
                        // });
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Create',
                        style: TextStyles.h8.copyWith(
                            color: ColorPalette.backgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
