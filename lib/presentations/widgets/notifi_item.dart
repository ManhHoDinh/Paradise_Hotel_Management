import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:paradise/core/models/notification_model.dart';

import '../../../core/helpers/text_styles.dart';

import '../../core/constants/color_palatte.dart';

class NotifiItem extends StatefulWidget {
  NotifiItem({super.key, required this.notification});
  NotificationModel notification;
  @override
  State<NotifiItem> createState() => _NotifiItemState();
}

class _NotifiItemState extends State<NotifiItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotificationModel notifiModel = widget.notification;
    return Container(
      padding: EdgeInsets.only(left: 19, top: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
              color: ColorPalette.primaryColor.withOpacity(0.75), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                notifiModel.heading,
                style: TextStyles.titlenotifi,
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            notifiModel.description,
            style: TextStyles.timenotifi,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(
                'By : ${notifiModel.postAuthor}',
                style: TextStyles.timenotifi.copyWith(fontSize: 10),
              ),
              Spacer(),
              Text(
                '${notifiModel.postTime.hour}:${notifiModel.postTime.minute} - ${notifiModel.postTime.day}/${notifiModel.postTime.month}/${notifiModel.postTime.year}',
                style: TextStyles.titlenotifi.copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
