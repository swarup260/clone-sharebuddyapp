import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final Widget child;

  RegisterScreen({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('REGISTER')],
        ),
      ),
    );
  }
}
