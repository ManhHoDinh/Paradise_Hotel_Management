import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/AuthFunctions.dart';
import 'package:paradise/core/models/user_model.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/helpers/text_styles.dart';
import '../../../core/models/room_model.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dialog.dart';
import '../../widgets/inputTitleWidget.dart';
import '../../widgets/question_yes_no_dialog.dart';

class EditStaffScreen extends StatefulWidget {
  final UserModel userModel;
  const EditStaffScreen({super.key, required this.userModel});

  @override
  State<EditStaffScreen> createState() => _EditStaffScreenState();
}

class _EditStaffScreenState extends State<EditStaffScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formRegisterKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.userModel.Name;
    phoneController.text = widget.userModel.PhoneNumber;
    positionController.text = widget.userModel.Position;
    emailController.text = widget.userModel.Email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text('EDIT USER',
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
              SizedBox(
                height: 40,
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Phone number',
                    labelStyle:
                        TextStyle(color: ColorPalette.grayText, fontSize: 12),
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
                controller: nameController,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Full Name',
                    labelStyle:
                        TextStyle(color: ColorPalette.grayText, fontSize: 12),
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
                    return "Position is invalid!";
                  } else
                    return null;
                },
                controller: positionController,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: ColorPalette.bgTextFieldColor,
                    labelText: 'Position',
                    labelStyle:
                        TextStyle(color: ColorPalette.grayText, fontSize: 12),
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
              Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 150,
                  child: ButtonDefault(
                      label: 'Save',
                      onTap: () {
                        if (formRegisterKey.currentState!.validate()) {
                          UpdateStaff(
                              name: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              position: positionController.text);
                        }
                      })),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 150,
                  child: ButtonDefault(
                    label: 'Delete',
                    backgroundColor: ColorPalette.redColor,
                    onTap: () {
                      DeleteRoomKind();
                    },
                  )),

              // Row(
              //   children: [
              //     Checkbox(
              //         value: isAccept,
              //         onChanged: (isChecked) {
              //           setState(() {
              //             isAccept = isChecked!;
              //           });
              //           ;
              //         }),
              //     Expanded(
              //       child: Text(
              //         'I agree to Hotel Management of Service, Payments Terms of Service.',
              //         style: TextStyles.defaultMonth.DarkPrimaryTextColor,
              //         maxLines: 2,
              //         overflow: TextOverflow.clip,
              //       ),
              //     )
              //   ],
              // ),
            ]),
          ),
        ),
      ),
    );
  }

  void DeleteRoomKind() async {
    try {
      showDialog(
          context: context,
          builder: (_context) {
            return QuestionYesNoDialog(
              task: 'Delete Staff',
              icon: FontAwesomeIcons.solidTrashCan,
              yesOnTap: () async {
                final doc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(widget.userModel.ID);
                await doc.delete();

                Navigator.pop(context);
                await showDialog(
                    context: _context,
                    builder: (_context) {
                      return DialogOverlay(
                        isSuccess: true,
                        task: 'Delete Staff',
                      );
                    }); //.whenComplete(() => Navigator.of(context).pop());
                Navigator.of(context).pop();
              },
              noOnTap: () {
                Navigator.pop(context);
              },
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Delete Staff',
              error: e.toString(),
            );
          });
    }
  }

  void UpdateStaff(
      {required String name,
      required String position,
      required String phoneNumber,
      required String email}) async {
    try {
      if (name == '') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Edit Staff',
                error: "Input Type Name, please!!!",
              );
            });
      } else if (position == '') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Edit Staff',
                error: "Input Type Position, please!!!",
              );
            });
      } else if (phoneNumber == ' ') {
        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: false,
                task: 'Edit Staff',
                error: "Input Type Phone Number, please!!!",
              );
            });
      } else {
        final doc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.userModel.ID);
        await doc.update({
          'Name': name,
          'PhoneNumber': phoneNumber,
          'Position': position,
        });

        showDialog(
            context: context,
            builder: (context) {
              return DialogOverlay(
                isSuccess: true,
                task: 'Update Staff',
              );
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogOverlay(
              isSuccess: false,
              task: 'Update Staff',
              error: e.toString(),
            );
          });
    }
  }
}
