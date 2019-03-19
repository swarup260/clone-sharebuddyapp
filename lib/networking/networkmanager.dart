import 'dart:convert';
import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

class NetworkManager {
  final headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.NykEM4bbRJYDCkP84ExLGhOkqBkDCe-avND2YoHXOFY",
  };

  Future<dynamic> postRequest(String requestUrl, dynamic params) async {
    final http.Response response =
        await http.post(requestUrl, headers: headers, body: jsonEncode(params));
    /* final http.Response response =
        await http.post(requestUrl, headers: headers, body: params); */
    if (response.statusCode == 200) {
      print(json.decode(response.body));

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  /* 
    example
  Future<dynamic> getRequest =
      networkManager.getRequest(apiManager.getAllLocation);
  getRequest
      .then((value) => print(value))
      .catchError((onError) => print(onError)); */

  Future<dynamic> getRequest(String requestUrl) async {
    final http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
