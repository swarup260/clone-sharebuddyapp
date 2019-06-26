// To parse this JSON data, do
//
//     final getLocation = getLocationFromJson(jsonString);

import 'dart:convert';

GetLocation getLocationFromJson(String str) =>
    GetLocation.fromJson(json.decode(str));

String getLocationToJson(GetLocation data) => json.encode(data.toJson());

class GetLocation {
  bool status;
  String message;
  List<Datum> data;

  GetLocation({
    this.status,
    this.message,
    this.data,
  });

  factory GetLocation.fromJson(Map<String, dynamic> json) => new GetLocation(
        status: json["status"],
        message: json["message"],
        data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  GeoLocation location;
  List<String> workingTime;
  bool status;
  bool verified;
  String id;
  String code;
  String landmark;
  String country;
  String state;
  String city;
  String workingDays;
  String from;
  String to;
  String price;
  String kilometer;
  String type;
  String name;

  Datum({
    this.location,
    this.workingTime,
    this.status,
    this.verified,
    this.id,
    this.code,
    this.landmark,
    this.country,
    this.state,
    this.city,
    this.workingDays,
    this.from,
    this.to,
    this.price,
    this.kilometer,
    this.type,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
        location: GeoLocation.fromJson(json["location"]),
        workingTime: new List<String>.from(json["workingTime"].map((x) => x)),
        status: json["status"],
        verified: json["verified"],
        id: json["_id"],
        code: json["code"],
        landmark: json["landmark"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        workingDays: json["workingDays"],
        from: json["from"],
        to: json["to"],
        price: json["price"],
        kilometer: json["kilometer"],
        type: json["type"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "workingTime": new List<dynamic>.from(workingTime.map((x) => x)),
        "status": status,
        "verified": verified,
        "_id": id,
        "code": code,
        "landmark": landmark,
        "country": country,
        "state": state,
        "city": city,
        "workingDays": workingDays,
        "from": from,
        "to": to,
        "price": price,
        "kilometer": kilometer,
        "type": type,
        "name": name,
      };
}

class GeoLocation {
  List<double> coordinates;
  String type;

  GeoLocation({
    this.coordinates,
    this.type,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) => new GeoLocation(
        coordinates:
            new List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": new List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}
