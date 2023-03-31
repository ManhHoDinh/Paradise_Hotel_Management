class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? type;
  int? price;
  String? name;
  //String? hotelID;
  //List<String> images = [];
  RoomModel({this.roomID, this.PrimaryImage, this.name, this.type, this.price});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'name': name,
        'type': type,
        'price': price,
        'PrimaryImage': PrimaryImage
      };

  static RoomModel fromJson(Map<String, dynamic> json) => RoomModel(
      roomID: json['roomID'],
      name: json['name'],
      type: json['type'],
      price: int.parse(json['price']),
      PrimaryImage: json['PrimaryImage']);
}
