import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                "ShareBuddy".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text('Version 1.0.0'),
              SizedBox(
                height: 10.0,
              ),
              CircleAvatar(
                backgroundColor: Color(0xFFf7fbff),
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 80.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text('2019 \u00a9 ShareBuddy'),
              Text('All right reserved.'),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Container(
                  height: 20.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'licenses'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                onTap: () {
                  _launchURL("https://www.sharebuddyapp.com/licenses.html");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
