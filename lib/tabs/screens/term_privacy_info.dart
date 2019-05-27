import 'package:flutter/material.dart';

class TermPrivacyTab extends StatelessWidget {
  final Widget child;

  TermPrivacyTab({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Term & Privacy Info."),
      ),
      body: ListView(
        children: <Widget>[
          RichText(
            text: TextSpan(
              text:
                  'When I first had to work with the notion of secured communication between a Client and a Server, I had to develop a solution that worked with old protocols like X25 or RS-232 in C-Language without using any library.of the requests. So I gave it a try and came to the following solution.',
              style: DefaultTextStyle.of(context).style,
            ),
          )
        ],
      ),
    );
  }
}
