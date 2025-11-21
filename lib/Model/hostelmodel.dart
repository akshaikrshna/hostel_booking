import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Hostelmodel> hostelmodelFromJson(String str) =>
    List<Hostelmodel>.from(json.decode(str).map((x) => Hostelmodel.fromJson(x)));

String hostelmodelToJson(List<Hostelmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hostelmodel {
  Amenities? amenities;
  Timestamp? createdAt;
  String? address;
  String? ownerName;
  String? phone;
  String? price;
  String? hostelName;
  List<String>? imageUrl;
  String? availableBeds;
  String? location;
  String? discription;
  String? selectedgenter;
  String? selecteddormetry;

  Hostelmodel({
    this.amenities,
    this.createdAt,
    this.address,
    this.ownerName,
    this.phone,
    this.price,
    this.hostelName,
    this.imageUrl,
    this.availableBeds,
    this.location,
    this.discription,
    this.selectedgenter,
    this.selecteddormetry,
  });

  /// 🔹 Create a model from JSON / Firestore Map
  factory Hostelmodel.fromJson(Map<String, dynamic> json) => Hostelmodel(
        amenities: json["amenities"] == null
            ? null
            : Amenities.fromJson(json["amenities"]),
        createdAt: json["createdAt"] is Timestamp
            ? json["createdAt"]
            : json["createdAt"] != null
                ? Timestamp.fromMillisecondsSinceEpoch(json["createdAt"])
                : null,
        address: json["address"],
        ownerName: json["ownerName"],
        phone: json["phone"],
        price: json["price"].toString(),
        hostelName: json["hostelName"],
         imageUrl:json["imageUrl"] !=null?List<String>.from(json["imageUrl"].map((x) => x)):[],
     
        availableBeds: json["availableBeds"].toString(),
        location: json["location"],
        discription: json["discription"],
        selectedgenter: json["selectedgenter"],
        selecteddormetry: json["selecteddormetry"]
      );


  Map<String, dynamic> toJson() => {
        "amenities": amenities?.toJson(),
        "createdAt": createdAt,
        "address": address,
        "ownerName": ownerName,
        "phone": phone,
        "price": price,
        "hostelName": hostelName,
         "imageUrl": imageUrl!=null? List<dynamic>.from(imageUrl!.map((x) => x)):[],
        
        "availableBeds": availableBeds,
        "location": location,
        "discription":discription,
        "selectedgenter":selectedgenter,
        "selecteddormetry":selecteddormetry,
      };
}

class Amenities {
  bool? parking;
  bool? attachedBathroom;
  bool? furnished;
  bool? locker;
  bool? food;

  Amenities({
    this.parking,
    this.attachedBathroom,
    this.furnished,
    this.locker,
    this.food,
  });

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        parking: json["parking"],
        attachedBathroom: json["attachedBathroom"],
        furnished: json["furnished"],
        locker: json["locker"],
        food: json["food"],
      );

  Map<String, dynamic> toJson() => {
        "parking": parking,
        "attachedBathroom": attachedBathroom,
        "furnished": furnished,
        "locker": locker,
        "food": food,
      };
}
