import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Licenses.dart';

class AboutUsPage extends StatelessWidget {
  final Widget child;

  AboutUsPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "ShareBubby".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text('Version 1.0.0'),
              Icon(
                FontAwesomeIcons.car,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(' 2019-2040 ShareBubby Inc.'),
              Text('All right reserved.'),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Text(
                  'licenses'.toUpperCase(),
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Licenses()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
