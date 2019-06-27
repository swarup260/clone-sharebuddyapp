import 'dart:io';

import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/apiEndpoint.dart';
import './tabs/screens/walk_through.dart';
import 'api/networkManager.dart';
import 'home.dart';

void main() {
  Admob.initialize(getAppId());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Buddy',
      theme: ThemeData(
        primaryColorDark: Colors.amber[600],
        primaryColor: Colors.amber,
        primaryIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        indicatorColor: Colors.black,
        fontFamily: 'Rubik',
      ),
      // home: Home(),
      home: FutureBuilder(
        future: isShowWalkThrough(),
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data) {
            return Home();
          } else {
            return Walkthrough();
          }
        },
      ),
    );
  }

  Future<bool> isShowWalkThrough() async {
    final SharedPreferences prefs = await getPrefs();
    final getIsregisterUser = prefs.getBool("isregisterUser") ?? false;
    if (!getIsregisterUser) {
      final isregisterUser = await registerUser();
      prefs.setBool("isregisterUser", isregisterUser);
    }

    return prefs.getBool("walkThroughView") ?? false;
  }

  Future<bool> registerUser() async {
    final deviceId = await getDeviceIdentity();
    try {
      final result = await ajaxPost(getApiEndpoint(endpoint.register), {
        "deviceId": deviceId,
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "pushTokenId": "testing"
      });
      return result.status;
    } catch (e) {
      return false;
    }
  }
}
