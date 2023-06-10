import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptModel {
  String? guestName;
  String? address = '';
  String? receiptID;
  int total = 0;
  String? phoneNumber = '';
  DateTime checkOutDate;
  List<String> rentalFormIDs = [];


  ReceiptModel({
    required this.receiptID,
    required this.guestName,
    this.address,
    required this.total,
    this.phoneNumber,
    required this.checkOutDate,
    required this.rentalFormIDs,
  });

  static List<ReceiptModel> AllReceipts = [];

  Map<String, dynamic> toJson() => {
        'ReceiptID': receiptID,
        'GuestName': guestName,
        'Address': address,
        'Total': total.toString(),
        'CheckOutDate': Timestamp.fromDate(checkOutDate!),
        'RentalFormIDs': rentalFormIDs,
        'PhoneNumber': phoneNumber
      };
  static String CollectionName = 'Receipts';
  static ReceiptModel fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      receiptID: json['ReceiptID'],
      guestName: json['GuestName'],
      address: json['Address'],
      total: int.parse(json['Total']),
      rentalFormIDs: List.from(json['RentalFormIDs']),
      phoneNumber: json['PhoneNumber'],
      checkOutDate: (json['CheckOutDate'] as Timestamp).toDate(),
    );
  }
  
  }
