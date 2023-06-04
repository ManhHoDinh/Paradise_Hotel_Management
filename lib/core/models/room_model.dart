import 'package:paradise/core/models/room_kind_model.dart';

class RoomModel {
  String? roomID;
  String? PrimaryImage;
  String? RoomKindID;
  String? State;
  String? Description;
  List<String> SubImages = [];
  int? maxCapacity;
  int? NumberGuestBeginSubCharge;
  double? SubChargeRatio;
  RoomModel(
      {required this.roomID,
      required this.PrimaryImage,
      required this.RoomKindID,
      required this.State,
      required this.SubImages,
      required this.Description,
      required this.maxCapacity,
      required this.NumberGuestBeginSubCharge,
      required this.SubChargeRatio});
  Map<String, dynamic> toJson() => {
        'roomID': roomID,
        'roomKindID': RoomKindID,
        'PrimaryImage': PrimaryImage,
        'State': State,
        'SubImages': SubImages,
        'Description': Description,
        'maxCapacity': maxCapacity.toString(),
        'NumberGuestBeginSubCharge': NumberGuestBeginSubCharge.toString(),
        'SubChargeRatio': SubChargeRatio.toString()
      };
  static String CollectionName = 'Rooms';

  static RoomModel fromJson(Map<String, dynamic> json) {
    //List<String> names = List.from(json['names']);
    return RoomModel(
        roomID: json['roomID'],
        RoomKindID: json['roomKindID'],
        PrimaryImage: json['PrimaryImage'],
        State: json['State'],
        SubImages: List.from(json['SubImages']),
        Description: json['Description'],
        maxCapacity: int.parse(json['maxCapacity']),
        ///Sua thanh NumberGuestBeginSubCharge
        NumberGuestBeginSubCharge: int.parse(json['NumberGuestBeginSubCharge']),
        SubChargeRatio: double.parse(json['SubChargeRatio']));
  }

  static List<RoomModel> AllRooms = [];

  int getPrice() {
    try {
      return RoomKindModel.getRoomKindPrice(RoomKindID ?? '');
    } catch (e) {
      return 0;
    }
  }

  static int getPriceWithRoomID(String id) {
    try {
      List<RoomModel> Rooms =
          RoomModel.AllRooms.where((room) => room.roomID == id).toList();
      return RoomKindModel.getRoomKindPrice(Rooms[0].RoomKindID ?? '');
    } catch (e) {
      return 0;
    }
  }

  static bool ExistRoomWithRoomKindID(String id) {
    try {
      print(id);
      List<RoomModel> Rooms =
          RoomModel.AllRooms.where((room) => room.RoomKindID == id).toList();
      return Rooms.length != 0;
    } catch (e) {
      return false;
    }
  }

  static String getRoomImageByID(String id) {
    try {
      RoomModel room =
          RoomModel.AllRooms.where((roomCheck) => roomCheck.roomID! == id)
              .first;
      return room.PrimaryImage ?? "";
    } catch (e) {
      return "";
    }
  }
}
