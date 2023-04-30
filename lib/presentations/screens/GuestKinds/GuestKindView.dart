import 'package:flutter/material.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/firebase_request.dart';
import 'package:paradise/core/models/guest_kind_model.dart';
import 'package:paradise/presentations/widgets/guest_kind_widget.dart';

import 'AddGuestKindScreen.dart';

class GuestKindView extends StatefulWidget {
  const GuestKindView({super.key});
  static final String routeName = 'guest_kind_view';
  @override
  State<GuestKindView> createState() => _GuestKindViewState();
}

class _GuestKindViewState extends State<GuestKindView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text('GUEST TYPE'),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.primaryColor,
        child: Text(
          '+',
          style: TextStyles.h1.copyWith(color: ColorPalette.backgroundColor),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddGuestKindScreen.routeName);
        },
      ),
      body: Column(
        children: [
         
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FireBaseDataBase.readGuestKinds(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong! ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    GuestKindModel.AllGuestKinds = snapshot.data!;
                    return Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 80),
                      child: Column(
                        children: GuestKindModel.AllGuestKinds.map(
                            (e) => GuestKindWidget(
                                  GuestKind: e,
                                )).toList(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
