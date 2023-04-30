class GuestKindModel {
  String? GuestKindID;
  String? Name;
  double ratio;
  GuestKindModel({
    required this.GuestKindID,
    required this.Name,
    required this.ratio,
  });
  static String CollectionName = 'GuestKinds';
  Map<String, dynamic> toJson() => {
        'GuestKindID': GuestKindID,
        'GuestKindName': Name,
        'Ratio': ratio.toString(),
      };

  static GuestKindModel fromJson(Map<String, dynamic> json) {
    return GuestKindModel(
      GuestKindID: json['GuestKindID'],
      Name: json['GuestKindName'],
      ratio: double.parse(json['Ratio']),
    );
  }

  static List<String> kindItems = [];
  static List<GuestKindModel> AllGuestKinds = [];

  static String getGuestKindName(String id) {
    try {
      GuestKindModel kindSelected = GuestKindModel.AllGuestKinds.where(
          (guestKind) => guestKind.GuestKindID! == id).first;
      return kindSelected.Name ?? '';
    } catch (e) {
      return '';
    }
  }

  static double getForeignGuestRatio() {
    try {
      GuestKindModel kindSelected = GuestKindModel.AllGuestKinds.where(
          (guestKind) => guestKind.Name! == "Foreign").first;
      return kindSelected.ratio;
    } catch (e) {
      return 0;
    }
  }
}
