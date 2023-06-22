import 'dart:typed_data';
import 'package:intl/intl.dart';

class Event {
  int id;
  String name;
  String description;
  String? location;
  DateTime? date;
  dynamic wishlist;
  int? guests;
  String partyImage = 'assets/utils/party.jpg';
  Uint8List? imageBytes;
  String? owner;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      this.location,
      this.date,
      this.wishlist,
      this.guests,
      this.owner,
      this.imageBytes});

  factory Event.fromJson(Map<String, dynamic> json) {
    final DateTime? date =
        json['date'] != null ? DateTime.parse(json['date']) : null;

    final Wishlist wishlist = Wishlist.fromJson(json['wishlist']);

    final Uint8List? image = json['image'] != null
        ? Uint8List.fromList(json['image']['data'].cast<int>())
        : null;
    return Event(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        date: date,
        wishlist: wishlist,
        guests: json["participants"],
        owner: json["owner"],
        imageBytes: image);
  }

  String get getEventDate =>
      date != null ? DateFormat('d, MMMM yyyy').format(date!) : '';

  String get getEventTime =>
      date != null ? DateFormat('hh:mm a').format(date!) : '';

  Map<String, dynamic> eventToJson(Event data) {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["id"] = data.id;
    json["name"] = data.name;
    json["description"] = data.description;
    json["location"] = data.location;
    json["date"] = data.date;
    json["wishlist"] = data.wishlist;
    return json;
  }
}

class CreateEventDto {
  String name;
  String description;
  String? location;
  DateTime? date;

  CreateEventDto(
      {required this.name,
      required this.description,
      this.location,
      this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["name"] = name;
    json["description"] = description;
    if (location != null) {
      json["location"] = location;
    }
    if (date != null) {
      json["date"] = DateFormat('yyyy-MM-dd hh:mm:ss').format(date!);
    }
    return json;
  }
}

class UpdateEventDto {
  String name;
  String description;
  String? location;
  DateTime? date;

  UpdateEventDto(
      {required this.name,
      required this.description,
      this.location,
      this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["name"] = name;
    json["description"] = description;
    if (location != null) {
      json["location"] = location;
    }
    if (date != null) {
      json["date"] = DateFormat('yyyy-MM-dd hh:mm:ss').format(date!);
    }
    return json;
  }
}

class Wishlist {
  bool active;
  List<Item> items;

  Wishlist({required this.active, required this.items});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    final List<dynamic> items = json['items'];
    return Wishlist(
      active: json["active"],
      items: items.isNotEmpty
          ? items.map((item) => Item.fromJson(item)).toList()
          : [],
    );
  }
}

class Item {
  String name;
  String description;
  int quantity;
  int? imageId;

  Item(
      {required this.name,
      required this.description,
      required this.quantity,
      this.imageId});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        name: json["name"],
        description: json["description"],
        quantity: int.parse(json["quantity"]),
        imageId: json["image"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json["name"] = name;
    json["description"] = description;
    json["quantity"] = quantity.toString();
    return json;
  }
}
