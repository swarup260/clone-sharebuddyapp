// To parse this JSON data, do
//
//     final getToken = getTokenFromJson(jsonString);

import 'dart:convert';

GetToken getTokenFromJson(String str) => GetToken.fromJson(json.decode(str));

String getTokenToJson(GetToken data) => json.encode(data.toJson());

class GetToken {
    bool status;
    String data;

    GetToken({
        this.status,
        this.data,
    });

    factory GetToken.fromJson(Map<String, dynamic> json) => new GetToken(
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
    };
}
