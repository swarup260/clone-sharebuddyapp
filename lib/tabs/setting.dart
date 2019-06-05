import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../models/getMessage.dart';
import '../api/apiEndpoint.dart';
import '../api/networkManager.dart';
import '../tabs/screens/term_privacy_info.dart';
import '../tabs/screens/about_us.dart';

class SettingTab extends StatelessWidget {
  SettingTab({Key key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          /* AppBar */
          new CustomAppBar(deviceHeight: deviceHeight, context: context),
          /* body */
          Flexible(
            child: ListView(
              children: <Widget>[
                /* ReceiveNotification(
                    icons: Icons.notifications,
                    settingTab: "Receive Notification"), */
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
                          return new SendFeedback(
                            context: context,
                            globalKey: _scaffoldKey,
                          );
                        });
                  },
                ),
                MeunTab(
                    icons: Icons.vpn_key,
                    settingTab: "Term and Privacy Policy",
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
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AdmobBanner(
                adUnitId: getBannerAdUnitId(bannerAdType.LARGE_BANNER),
                adSize: AdmobBannerSize.LARGE_BANNER,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* Send Feeback */
class SendFeedback extends StatefulWidget {
  const SendFeedback({Key key, @required this.context, this.globalKey})
      : super(key: key);

  final BuildContext context;
  final GlobalKey<ScaffoldState> globalKey;

  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  final _formKey = GlobalKey<FormState>();
  String inputFeedback = "";
  String message = "";
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          maxLines: 6,
          decoration: InputDecoration(
              hintText: "Please Give Us Suggestion to Improve",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)))),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter some text";
            }
            inputFeedback = value;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Icon(Icons.send),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              /* post Data to Server */
              Map<String, String> postData = {
                "deviceId": await getDeviceIdentity(),
                "feedback": inputFeedback
              };

              final result = await ajaxPost(
                  getApiEndpoint(endpoint.addFeedback), postData);

              final response = getMessageFromJson(result);
              if (response.status) {
                message = "Thank's for your Suggestion";
              } else {
                message = "Fail to Sent Try again...";
              }
              SnackBar snackBar = new SnackBar(
                content: Text(message),
                duration: Duration(seconds: 2),
              );
              widget.globalKey.currentState.showSnackBar(snackBar);
              Navigator.of(context).pop();
            }
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   "SHAREBUDDY",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
          // )
          RichText(
            text: TextSpan(
              text: 'SHARE ',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
              children: <TextSpan>[
                TextSpan(
                    text: 'BUDDY',
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  child: Icon(FontAwesomeIcons.facebook, size: 25),
                  onTap: () {
                    _launchURL("https://www.facebook.com/sharebuddyapp/");
                  }),
              SizedBox(width: 20),
              GestureDetector(
                child: Icon(FontAwesomeIcons.twitter, size: 25),
                onTap: () {
                  _launchURL("https://www.twitter.com");
                },
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: Icon(FontAwesomeIcons.instagram, size: 25),
                onTap: () {
                  _launchURL("https://www.instagram.com/sharebuddyapp/");
                },
              )
            ],
          )
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

/* 

Container(
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
      )

 */
