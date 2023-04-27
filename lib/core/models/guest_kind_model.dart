class GuestKindModel {
  String? ID;
  String? Name;
  double ratio;
  GuestKindModel({
    required this.ID,
    required this.Name,
    required this.ratio,
  });
  Map<String, dynamic> toJson() => {
        'GuestKindID': ID,
        'GuestKindName': Name,
        'Ratio': ratio,
      };

  static GuestKindModel fromJson(Map<String, dynamic> json) {
    return GuestKindModel(
      ID: json['GuestKindID'],
      Name: json['GuestKindName'],
      ratio: double.parse(json['Ratio']),
    );
  }

  static List<String> kindItems = [];
  static List<GuestKindModel> AllGuestKinds = [];

  static String getGuestKindName(String id) {
    GuestKindModel kindSelected =
        GuestKindModel.AllGuestKinds.where((roomKind) => roomKind.ID! == id)
            .first;
    return kindSelected.Name ?? '';
  }

  static double getGuestKindRatio(String id) {
    GuestKindModel kindSelected =
      GuestKindModel.AllGuestKinds.where((element) => element.ID == id)
        .first;
    return kindSelected.ratio;
  }
}
