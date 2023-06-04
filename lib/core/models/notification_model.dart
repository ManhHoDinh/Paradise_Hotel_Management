import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String heading;
  String description;
  DateTime postTime;
  String postAuthor;
  NotificationModel(
      {required this.heading,
      required this.description,
      required this.postTime,
      required this.postAuthor});
  Map<String, dynamic> toJson() => {
        'heading': heading,
        'description': description,
        'postTime': Timestamp.fromDate(postTime),
        'postAuthor': postAuthor
      };
  static NotificationModel fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        heading: json['heading'],
        description: json['description'],
        postAuthor: json['postAuthor'],
        postTime: (json['postTime'] as Timestamp).toDate());
  }

  static String CollectionName = 'Notification';
  static List<NotificationModel> AllNotificationModels = [];
}
