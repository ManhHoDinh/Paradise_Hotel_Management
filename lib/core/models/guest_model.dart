import 'package:paradise/core/models/guest_kind_model.dart';

class Guest {
  String? cmnd;
  String? name;
  String? guestKindId;
  String? address;
  Guest({
    required this.cmnd,
    required this.name,
    required this.guestKindId,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'CMND': cmnd,
        'Name': name,
        'GuestKindID': guestKindId,
        'Address': address,
      };
      
  static Guest fromJson(Map<String, dynamic> json) => Guest(
      cmnd: json['CMND'],
      name: json['Name'],
      guestKindId: json['GuestKindID'],
      address: json['Address']);

  double getRatio() {
    try {
      return GuestKindModel.getGuestKindRatio(guestKindId ?? '');
    } catch (e) {
      return 0;
    }
  }
}
