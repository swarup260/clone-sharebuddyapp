/**
 * Module that handles all communications with the server
 */
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


// the unique ID of the application
const String _applicationId = "ShareBuddy";

// the storage key for the token
const String _storageKeyMobileToken = "";

// the URL of the Web Server
const String _urlBase = "http://sharebuddy-api.herokuapp.com";

// the URI to the Web Server Web API
//const String _serverApi = "/api/mobile/";

// the mobile device unique identity
String _deviceIdentity = "";

/// ----------------------------------------------------------
/// Method which is only run once to fetch the device identity
/// ----------------------------------------------------------
final DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();

Future<String> _getDeviceIdentity() async {
  if (_deviceIdentity == '') {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
        _deviceIdentity = "${info.device}-${info.id}";
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
        _deviceIdentity = "${info.model}-${info.identifierForVendor}";
      }
    } on PlatformException {
      _deviceIdentity = "unknown";
    }
  }

  return _deviceIdentity;
}

/// ----------------------------------------------------------
/// Method that returns the token from Shared Preferences
/// ----------------------------------------------------------

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String> _getMobileToken() async {
  final SharedPreferences prefs = await _prefs;

  return prefs.getString(_storageKeyMobileToken) ?? '';
}

/// ----------------------------------------------------------
/// Method that saves the token in Shared Preferences
/// ----------------------------------------------------------
Future<bool> _setMobileToken(String token) async {
  final SharedPreferences prefs = await _prefs;

  return prefs.setString(_storageKeyMobileToken, token);
}

/// ----------------------------------------------------------
/// Http Handshake
///
/// At application start up, the application needs to synchronize
/// with the server.
/// How does this work?
///   - A. If a previous token exists, the latter is sent to
///   -   the server to be validated.  If the validation is Ok,
///   -   the user is re-authenticated and a new token is returned
///   -   to the application.  The application then stores it.
///
///   - B. If no token exists, the application sends a request
///   -   for a new token to the server, which returns the
///   -   the requested token.  This token will be saved.
/// ----------------------------------------------------------
Future<dynamic> handShake() async {
  bool _status = false;
  // Check Token Set or Not
  if(await _getMobileToken() == "")
  {
    final response = await ajaxGet('user/getToken?deviceId=123');
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      _status = responseBody["status"];
      switch(_status)
      {
        case true:
        await _setMobileToken(responseBody["data"]);
        break;

        case false:
        await _setMobileToken("");
        break;
      }
    }
    return response;
  }
}

/// ----------------------------------------------------------
/// Http "GET" request
/// ----------------------------------------------------------
Future<dynamic> ajaxGet(String serviceName) async {
  try {
    final response = await http.get(_urlBase + '/$serviceName',
        headers: {
          'X-DEVICE-ID': await _getDeviceIdentity(),
          'X-TOKEN': await _getMobileToken(),
          'X-APP-ID': _applicationId
        });
    return response;
  } catch (e) {
    // An error was received
    throw new Exception("GET AJAX ERROR");
  }
}

/// ----------------------------------------------------------
/// Http "POST" request
/// ----------------------------------------------------------
Future<dynamic> ajaxPost(String serviceName, Map data) async {
  try {
    await handShake();
    final response = await http.post(_urlBase + '/$serviceName',
        body: json.encode(data),
        headers: {
          'X-DEVICE-ID': await _getDeviceIdentity(),
          'Authorization': "Bearer " + await _getMobileToken(),
          'X-APP-ID': _applicationId,
          'Content-Type': 'application/json; charset=utf-8',
        });
      return response;
  } catch (e) {
    // An error was received
    throw new Exception("POST AJAX ERROR");
  }
}