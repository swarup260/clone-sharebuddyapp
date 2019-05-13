import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share_buddy/models/getToken.dart';

class NetworkManager {
  String _url;
  String _token = "";
  NetworkManager({String url = "sharebuddy-api.herokuapp.com"}) {
    this._url = url;
  }
  /* List of Api Endpoint */
  final Map<String, String> _apiEndpoint = {
    "getAllLocation": "/location/getAllLocation",
    "getLocationFromTo": "/location/getLocationFromTo",
    "getLocationList": "/location/getLocationList",
    "getLocationList": "/location/getLocationList",
    "getLocationFromCurrent": "/location/getLocationFromCurrent",
    "register": "/user/register",
    "getToken": "/user/getToken",
    "addFeedback": "/user/addFeedback"
  };

  get apiEndpoint => _apiEndpoint;

  ///Map the url with Domain
  /*  Map<String, String> allEndpoint() =>
      _apiEndpoint.map((key, value) => MapEntry(key, _url + value)); */

  Future<GetToken> _requestToken(String deviceID) async {
    Uri urlEndpoint =
        Uri.http(_url, _apiEndpoint["getToken"], {"deviceId": deviceID});
    final http.Response response = await http.get(urlEndpoint);
    if (response.statusCode == 200) {
      return getTokenFromJson(response.body);
    } else {
      throw Exception('Error While Generating Token');
    }
  }

  String getToken(String deviceID) {
    if (_token != "") {
      return _token;
    } else {
      _requestToken(deviceID).then((GetToken value) {
        if (value.status) {
          _token = value.data;
        }
      }).catchError((error) => error);
      return _token;
    }
  }

  Future<dynamic> getRequest(String requestUrl, apiModel,
      {bool authFlag = true}) async {}
  Future<dynamic> postRequest(String requestUrl, apiModel,
      {bool authFlag = true}) async {}
}
