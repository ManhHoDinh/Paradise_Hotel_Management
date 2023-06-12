class UserModel {
  String ID;
  String Name;
  String PhoneNumber;
  String Email;
  String Position;
  String? identification;
  String? birthday;

  UserModel(
      {required this.ID,
      required this.Name,
      required this.PhoneNumber,
      required this.Email,
      required this.Position,
      this.birthday,
      this.identification});

  Map<String, dynamic> toJson() => {
        'ID': ID,
        'Name': Name,
        'PhoneNumber': PhoneNumber,
        'Email': Email,
        'Position': Position,
        'Identification': identification,
        'BirthDay': birthday,
      };
  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      ID: json['ID'],
      Name: json['Name'],
      PhoneNumber: json['PhoneNumber'],
      Email: json['Email'],
      Position: json['Position'],
      birthday: json['BirthDay'],
      identification: json['Identification']);
}
