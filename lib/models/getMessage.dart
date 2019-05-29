// To parse this JSON data, do
//
//     final getMessage = getMessageFromJson(jsonString);

import 'dart:convert';

GetMessage getMessageFromJson(String str) => GetMessage.fromJson(json.decode(str));

String getMessageToJson(GetMessage data) => json.encode(data.toJson());

class GetMessage {
    bool status;
    String message;

    GetMessage({
        this.status,
        this.message,
    });

    factory GetMessage.fromJson(Map<String, dynamic> json) => new GetMessage(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
