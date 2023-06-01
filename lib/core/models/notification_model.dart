import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String heading;
  String description;
  NotificationModel({
    required this.heading,
    required this.description,
  });
  Map<String, dynamic> toJson() => {
        'heading': heading,
        'description': description,
      };
  static NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      heading: json['heading'],
      description: json['description'],
    );
  }

  static String CollectionName = 'Notification';
  static List<NotificationModel> AllNotificationModels = [];
}
