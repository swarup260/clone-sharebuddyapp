import 'package:flutter/material.dart';
import 'package:share_buddy/tabs/screens/edit_account_screen.dart';
import 'package:share_buddy/tabs/screens/login_scrren.dart';
import 'package:share_buddy/tabs/screens/register_screen.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Buddy',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Colors.yellow,
        primaryIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        indicatorColor: Colors.black,
        fontFamily: 'Rubik',
      ),
      home: Home(),
      routes: {
        '/Login': (_) => LoginScreen(),
        '/Register': (_) => RegisterScreen(),
        '/Edit Account': (_) => EditAccountScreen()
      },
    );
  }
}
