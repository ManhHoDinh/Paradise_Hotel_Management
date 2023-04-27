import 'package:paradise/core/models/rentalform_mode.dart';

class ReceiptModel {
  String? guestName;
  String? address;
  String? receiptID;
  int? total;
  List<String> rentalForms = [];

  ReceiptModel({
    required this.receiptID,
    required this.guestName,
    required this.address,
    required this.total,
    required this.rentalForms,
  });

  static List<RentalFormModel> AllRentalFroms = [];

  Map<String, dynamic> toJson() => {
    'ReceiptID': receiptID,
    'GuestName': guestName,
    'Address': address,
    'Total': total,
    'RentalForms': rentalForms, 
  };

  static ReceiptModel fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      receiptID: json['ReceiptID'], 
      guestName: json['GuestName'], 
      address: json['Address'], 
      total: json['Total'], 
      rentalForms: List.from(json['RentalForms']),
    );
  }
}