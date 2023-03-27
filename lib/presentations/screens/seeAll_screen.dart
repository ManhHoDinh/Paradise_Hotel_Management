import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';
import 'package:paradise/core/models/room_model.dart';
import 'package:paradise/presentations/widgets/room_item.dart';

class SeeAllScreen extends StatelessWidget {
  final List<RoomModel> listRoom;
  const SeeAllScreen({super.key, required this.listRoom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          color: ColorPalette.backgroundColor,
          // child: RoomItem(AssetHelper.room1, "room1", "family", 1200),
          child: Column(children: [
            Container(
              padding:
                  const EdgeInsets.only(top: kMaxPadding, bottom: kMinPadding),
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    customBorder: CircleBorder(),
                    child: Container(
                      width: 26,
                      height: 26,
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: 18,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'All room',
                  style: TextStyles.defaultStyle.primaryTextColor,
                ),
              ]),
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.8,
                    children: listRoom
                        .map((e) =>
                            RoomItem(e.image!, e.name!, e.type!, e.cost!))
                        .toList())),
          ])),
    );
  }
}
