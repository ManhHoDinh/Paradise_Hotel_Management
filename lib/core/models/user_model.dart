class UserModel {
  String ID;
  String Name;
  String PhoneNumber;
  String Email;
  String Position;
  UserModel(
      {required this.ID,
      required this.Name,
      required this.PhoneNumber,
      required this.Email,
      required this.Position});

  Map<String, dynamic> toJson() => {
        'ID': ID,
        'Name': Name,
        'PhoneNumber': PhoneNumber,
        'Email': Email,
        'Position': Position
      };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        ID: json['ID'],
        Name: json['Name'],
        PhoneNumber: json['PhoneNumber'],
        Email: json['Email'],
        Position: json['Position'],
      );

}
