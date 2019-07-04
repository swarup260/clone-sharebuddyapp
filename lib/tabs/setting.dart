import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../models/getMessage.dart';
import '../api/apiEndpoint.dart';
import '../api/networkManager.dart';
import '../tabs/screens/about_us.dart';

class SettingTab extends StatefulWidget {
  SettingTab({Key key}) : super(key: key);

  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab>
    with AutomaticKeepAliveClientMixin<SettingTab> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Theme.of(context)
          .primaryColorDark, //or set color with: Color(0xFF0000FF)
    ));
    super.build(context);
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
                  icons: FontAwesomeIcons.locationArrow,
                  settingTab: "Add Location",
                  callback: () {
                    _launchURL("http://sharebuddy-addlocation.herokuapp.com/");
                  },
                  flag: true,
                ),
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
                      _launchURL(
                          "http://www.sharebuddyapp.com/term_privacy_policy.html");
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

  @override
  bool get wantKeepAlive => true;
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
          child: Icon(
            Icons.send,
            color: Theme.of(context).primaryColor,
          ),
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
              InkWell(
                child: Icon(FontAwesomeIcons.globe, size: 25),
                onTap: () {
                  _launchURL("http://www.sharebuddyapp.com/");
                },
                splashColor: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Icon(FontAwesomeIcons.facebook, size: 25),
                onTap: () {
                  _launchURL("https://www.facebook.com/sharebuddyapp/");
                },
                splashColor: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              SizedBox(width: 20),
              InkWell(
                child: Icon(FontAwesomeIcons.twitter, size: 25),
                onTap: () {
                  _launchURL("https://www.twitter.com");
                },
                splashColor: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                child: Icon(FontAwesomeIcons.instagram, size: 25),
                onTap: () {
                  _launchURL("https://www.instagram.com/sharebuddyapp/");
                },
                splashColor: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
            ],
          )
        ],
      ),
    );
  }
}

/* MeunTab Setting Tab */
class MeunTab extends StatelessWidget {
  const MeunTab(
      {Key key,
      @required this.icons,
      @required this.settingTab,
      this.callback,
      this.flag = false})
      : super(key: key);

  final IconData icons;
  final String settingTab;
  final Function callback;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(icons),
                  Padding(
                    child: Text(settingTab),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                ],
              ),
              if (flag)
                Flexible(
                  child: Icon(Icons.new_releases, size: 25),
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

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
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
