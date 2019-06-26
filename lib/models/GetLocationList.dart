// To parse this JSON data, do
//
//     final getLocationList = getLocationListFromJson(jsonString);

import 'dart:convert';

List<String> getLocationListFromJson(String str) => new List<String>.from(json.decode(str).map((x) => x));

String getLocationListToJson(List<String> data) => json.encode(new List<dynamic>.from(data.map((x) => x)));
