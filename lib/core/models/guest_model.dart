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
        'cmnd': cmnd,
        'name': name,
        'guestKindId': guestKindId,
        'address': address,
      };
  static Guest fromJson(Map<String, dynamic> json) => Guest(
      cmnd: json['cmnd'],
      name: json['name'],
      guestKindId: json['guestKindId'],
      address: json['address']);
}
