import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'api/apiEndpoint.dart';
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
      home: Home(),
    );
  }
}
