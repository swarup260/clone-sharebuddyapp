/* import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share_buddy/networking/apimanager.dart';

main(List<String> args) {
  NetworkManager networkManager = new NetworkManager();
  ApiManager apiManager = new ApiManager();

  Future request = networkManager.postRequest(apiManager.getLocationFromTo, {});
  Future getRequest = networkManager.getRequest(apiManager.getAllLocation);
  print(getRequest);
}

class NetworkManager {
  final headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.NykEM4bbRJYDCkP84ExLGhOkqBkDCe-avND2YoHXOFY",
  };

  Future<dynamic> postRequest(String requestUrl, dynamic params) async {
    http.Response response = await http.post(Uri.encodeFull(requestUrl),
        headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      print(json.decode(response.body));

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getRequest(String requestUrl) async {
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
} */

import 'package:share_buddy/networking/networkmanager.dart';

main(List<String> args) {
  // NetworkManager networkManager = NetworkManager(url: "localhost:3000");
  NetworkManager networkManager = NetworkManager();
  // print(networkManager.apiEndpoint);
  // String getToken = networkManager.allEndpoint()['getToken'];
  // Map<String, String> params = {"deviceId": "sadasdasdasdasd"};
  // print(Uri.http("sharebuddy-api.herokuapp.com", "/user/getToken", params)
  //     .toString());

  var token = networkManager.getToken("fhgfhfhjfhjfhf");
  print(token);
}
