// To parse this JSON data, do
//
//     final getLocation = getLocationFromJson(jsonString);

import 'dart:convert';

List<GetLocation> getLocationFromJson(String str) => new List<GetLocation>.from(json.decode(str).map((x) => GetLocation.fromJson(x)));

String getLocationToJson(List<GetLocation> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GetLocation {
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
    List<String> location;
    String from;
    String to;
    String price;
    String kilometer;
    String type;
    String name;

    GetLocation({
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
        this.location,
        this.from,
        this.to,
        this.price,
        this.kilometer,
        this.type,
        this.name,
    });

    factory GetLocation.fromJson(Map<String, dynamic> json) => new GetLocation(
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
        location: new List<String>.from(json["location"].map((x) => x)),
        from: json["from"],
        to: json["to"],
        price: json["price"],
        kilometer: json["kilometer"],
        type: json["type"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
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
        "location": new List<dynamic>.from(location.map((x) => x)),
        "from": from,
        "to": to,
        "price": price,
        "kilometer": kilometer,
        "type": type,
        "name": name,
    };
}
