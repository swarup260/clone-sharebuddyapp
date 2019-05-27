import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../tabs/screens/term_privacy_info.dart';
import '../tabs/screens/about_us.dart';
import 'package:share/share.dart';

class SettingTab extends StatelessWidget {
  SettingTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          /* AppBar */
          new CustomAppBar(deviceHeight: deviceHeight, context: context),
          /* body */
          Flexible(
            child: ListView(
              children: <Widget>[
                ReceiveNotification(
                    icons: Icons.notifications,
                    settingTab: "Receive Notification"),
                MeunTab(
                  icons: Icons.share,
                  settingTab: "Share",
                  callback: () {
                    Share.share('Check the our app Sharebuddy');
                  },
                ),
                MeunTab(
                  icons: Icons.feedback,
                  settingTab: "Feedback",
                  callback: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new SendFeedback(context: context);
                        });
                  },
                ),
                MeunTab(
                    icons: Icons.info,
                    settingTab: "Term & Privacy Info.",
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new TermPrivacyTab()));
                    }),
                MeunTab(
                  icons: FontAwesomeIcons.info,
                  settingTab: "About Us",
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new AboutUsPage()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/* Send Feeback */
class SendFeedback extends StatefulWidget {
  const SendFeedback({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: 'FeedBack',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1))),

                // hintText: hintText
              ),
            ),
          ],
        ),
        height: 200,
      ),
      actions: <Widget>[
        FlatButton(
          child: Icon(Icons.send),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}


/* Setting Tab */
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.deviceHeight,
    @required this.context,
  }) : super(key: key);

  final double deviceHeight;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight / 2 * 0.4,
      decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "ShareBuddy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
            ),
          )
        ],
      ),
    );
  }
}

/* MeunTab Setting Tab */
class MeunTab extends StatelessWidget {
  const MeunTab(
      {Key key, @required this.icons, @required this.settingTab, this.callback})
      : super(key: key);

  final IconData icons;
  final String settingTab;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icons),
              Padding(
                child: Text(settingTab),
                padding: EdgeInsets.only(left: 10.0),
              )
            ],
          ),
        ),
        onTap: callback,
      ),
    );
  }
}

/* ReceiveNotification Widgets */
class ReceiveNotification extends StatefulWidget {
  const ReceiveNotification(
      {Key key, @required this.icons, @required this.settingTab});

  final IconData icons;
  final String settingTab;

  @override
  _ReceiveNotificationState createState() => _ReceiveNotificationState();
}

class _ReceiveNotificationState extends State<ReceiveNotification> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(widget.icons),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(widget.settingTab),
                  )
                ],
              ),
              Flexible(
                child: Switch(
                  value: enabled,
                  onChanged: (bool enabled) {
                    setState(() {
                      enabled = true;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            if (enabled) {
              enabled = false;
            } else {
              enabled = true;
            }
          });
        },
      ),
    );
  }
}
