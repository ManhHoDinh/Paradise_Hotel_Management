class RoomDetail {
  String? roomID;
  int? type;
  double? price;
  List<String> images = [];
  RoomDetail(
      {required this.roomID,
      required this.type,
      required this.price,
      required this.images});

  Map<String, dynamic> toJson() => {
        'id': roomID,
        'name': type,
        'age': price,
        'birthday': images,
      };
  static RoomDetail fromJson(Map<String, dynamic> json) => RoomDetail(
      roomID: json['roomID'],
      type: json['type'],
      price: json['type'],
      images: json['images']);
}
class RoomModel {
  String? image;
  String? type;
  int? cost;
  String? name;
  RoomModel(this.image, this.name, this.type, this.cost);
}
