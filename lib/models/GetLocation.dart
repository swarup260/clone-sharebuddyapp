// To parse this JSON data, do
//
//     final getLocation = getLocationFromJson(jsonString);

import 'dart:convert';

List<GetLocation> getLocationFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<GetLocation>.from(
      jsonData.map((x) => GetLocation.fromJson(x)));
}

String getLocationToJson(List<GetLocation> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class GetLocation {
  List<String> workingTime;
  bool status;
  bool verified;
  String id;
  int code;
  String name;
  String landmark;
  List<double> location;
  String from;
  String to;
  String price;
  String type;
  String workingDays;
  String kilometer;
  String country;
  String state;
  String city;

  GetLocation({
    this.workingTime,
    this.status,
    this.verified,
    this.id,
    this.code,
    this.name,
    this.landmark,
    this.location,
    this.from,
    this.to,
    this.price,
    this.type,
    this.workingDays,
    this.kilometer,
    this.country,
    this.state,
    this.city,
  });

  factory GetLocation.fromJson(Map<String, dynamic> json) => new GetLocation(
        workingTime: new List<String>.from(json["workingTime"].map((x) => x)),
        status: json["status"],
        verified: json["verified"],
        id: json["_id"],
        code: json["code"],
        name: json["name"],
        landmark: json["landmark"],
        location:
            new List<double>.from(json["location"].map((x) => x.toDouble())),
        from: json["from"],
        to: json["to"],
        price: json["price"],
        type: json["type"],
        workingDays: json["workingDays"],
        kilometer: json["kilometer"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "workingTime": new List<dynamic>.from(workingTime.map((x) => x)),
        "status": status,
        "verified": verified,
        "_id": id,
        "code": code,
        "name": name,
        "landmark": landmark,
        "location": new List<dynamic>.from(location.map((x) => x)),
        "from": from,
        "to": to,
        "price": price,
        "type": type,
        "workingDays": workingDays,
        "kilometer": kilometer,
        "country": country,
        "state": state,
        "city": city,
      };
}
