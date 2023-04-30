class ReceiptModel {
  String? guestName;
  String? address;
  String? receiptID;
  int? total;
  List<String> rentalFormIDs = [];

  ReceiptModel({
    required this.receiptID,
    required this.guestName,
    required this.address,
    required this.total,
    required this.rentalFormIDs,
  });

  static List<ReceiptModel> AllReceipts = [];

  Map<String, dynamic> toJson() => {
        'ReceiptID': receiptID,
        'GuestName': guestName,
        'Address': address,
        'Total': total,
        'RentalForms': rentalFormIDs,
      };
  static String CollectionName = 'Receipts';
  static ReceiptModel fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      receiptID: json['ReceiptID'],
      guestName: json['GuestName'],
      address: json['Address'],
      total: json['Total'],
      rentalFormIDs: List.from(json['RentalFormIDs']),
    );
  }
}
