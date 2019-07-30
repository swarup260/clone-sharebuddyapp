import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Center(heightFactor: 3,child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(Icons.network_check),
          Text("No Network")
        ],),
        content: Text("No Internet connection.Make sure that Wi-Fi or mobile data is turned on,then try again."),
      ));
  }
}