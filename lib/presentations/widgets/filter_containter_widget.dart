import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class FilterContainerWidget extends StatefulWidget {
  final String name;
  final Icon icon1;
  final Icon? icon2;
  final Function() onTapIconDown;
  final Function()? onTapIconUp;
  const FilterContainerWidget(
      {super.key,
      required this.name,
      required this.icon1,
      this.icon2,
      required this.onTapIconDown,
      this.onTapIconUp});

  @override
  State<FilterContainerWidget> createState() => _FilterContainerWidgetState();
}

class _FilterContainerWidgetState extends State<FilterContainerWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>['Family room', 'private room'];
    String dropDownValue = list.first;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          border: Border.all(color: ColorPalette.grayText)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              widget.name,
              style: TextStyles.defaultStyle.grayText.copyWith(fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              widget.onTapIconUp!();
            },
            child: widget.icon2 ??
                SizedBox(
                  width: 12,
                ),
          ),
          InkWell(
              onTap: () {
                widget.onTapIconDown();
              },
              child: widget.icon1),
        ]),
      ),
    );
  }
}
// class FilterContainerWidget extends StatelessWidget {
//   final String name;
//   final Icon icon1;
//   final Icon? icon2;
//   final Function() onTapIconDown;
//   final Function()? onTapIconUp;

//   const FilterContainerWidget(
//       {super.key,
//       required this.name,
//       required this.icon1,
//       this.icon2,
//       required this.onTapIconDown,
//       this.onTapIconUp});

//   @override
//   Widget build(BuildContext context) {
//     List<String> list = <String>['Family room', 'private room'];
//     String dropDownValue = list.first;

//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(kMediumPadding),
//           border: Border.all(color: ColorPalette.grayText)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         child: Row(mainAxisSize: MainAxisSize.min, children: [
//           Container(
//             padding: const EdgeInsets.only(right: 4),
//             child: Text(
//               name,
//               style: TextStyles.defaultStyle.grayText.copyWith(fontSize: 14),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               onTapIconUp!();
//             },
//             child: icon2 ??
//                 SizedBox(
//                   width: 12,
//                 ),
//           ),
//           name == 'Type'
//               ? DropdownButton
//               (
//                 value: dropDownValue,
//                 items: list.map((e) => DropdownMenuItem(child: Text(e))).toList()
//               , onChanged: (String? value) {
                
//               })
//               : InkWell(
//                   onTap: () {
//                     onTapIconDown();
//                   },
//                   child: icon1),
//         ]),
//       ),
//     );
//   }
// }
