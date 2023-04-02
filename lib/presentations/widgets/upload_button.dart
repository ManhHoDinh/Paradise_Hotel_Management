import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paradise/core/constants/color_palatte.dart';
import 'package:paradise/core/constants/dimension_constants.dart';
import 'package:paradise/core/helpers/text_styles.dart';

class UploadButton extends StatefulWidget {
  final String label;
  final String icon;

  const UploadButton({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  List<XFile>? _images = [];

  Future getImages() async {
    final images = await ImagePicker().pickMultiImage();
    if (images.isEmpty) return;

    setState(() {
      for (var image in images) {
        this._images?.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget _previewImages() {
      if (!_images!.isEmpty) {
        return Container(
          width: width,
          height: height * 0.25,
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Image.file(File(_images![index].path),
                  fit: BoxFit.scaleDown,
                ),
              );
            },
            itemCount: _images!.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      } else {
        return Container();
      }
    }
    
    Widget _handlePreview() {
      return _previewImages();
    }

    return Column(
      children: [
        _handlePreview(),
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          onTap: getImages,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: kMinPadding * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(widget.icon),
                  margin: const EdgeInsets.only(right: kItemPadding),
                ),
                Text(
                  widget.label,
                  style: TextStyles.h6.copyWith(
                    color: ColorPalette.grayText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}