import 'package:flutter/material.dart';

class EditAccountScreen extends StatelessWidget {
  final Widget child;

  EditAccountScreen({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('EDIT ACCOUNT')],
        ),
      ),
    );
  }
}
