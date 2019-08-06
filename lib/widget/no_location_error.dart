import 'package:flutter/material.dart';

class NoLocationError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(heightFactor: 3,child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(Icons.not_listed_location),
          Text("No Sharing Point")
        ],),
        content: Text("No Sharing Point Available Within 5KM From Your Current Location. \n\n Please Try List Search :)"),
      ));
  }
}