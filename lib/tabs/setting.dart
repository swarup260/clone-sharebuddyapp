import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../tabs/screens/about_us.dart';
import 'package:share/share.dart';

class SettingTab extends StatelessWidget {
  final Widget child;

  SettingTab({Key key, this.child}) : super(key: key);
  List<String> settingTab = [
    "Receive Notification",
    "Share",
    "Feedback",
    "Term & Privacy Info.",
    "About Us"
  ];

  List<IconData> icons = [
    Icons.notifications,
    Icons.share,
    Icons.feedback,
    Icons.info,
    FontAwesomeIcons.info
  ];
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          /* AppBar */
          customAppBar(deviceHeight, context),
          /* body */
          Flexible(
            child: ListView(
              children: <Widget>[
                MeunTab(icons: icons[0], settingTab: settingTab[0]),
                MeunTab(
                  icons: icons[1],
                  settingTab: settingTab[1],
                  callback: () {
                    Share.share('Check the our app Sharebuddy');
                  },
                ),
                MeunTab(
                  icons: icons[2],
                  settingTab: settingTab[2],
                  callback: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1))),

                                      // hintText: hintText
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 100,
                                    decoration: InputDecoration(
                                      labelText: 'FeedBack',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(1))),

                                      // hintText: hintText
                                    ),
                                  ),
                                ],
                              ),
                              height: 150,
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
                        });
                  },
                ),
                MeunTab(icons: icons[3], settingTab: settingTab[3]),
                MeunTab(
                  icons: icons[4],
                  settingTab: settingTab[4],
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

/*   List<Widget> listViewChildren( List<IconData> icons, List<String> settingName, Widget meun){
    List<Widget> menuTab = [];
    for (var i = 0; i < icons.length; i++) {
      menuTab.add( Me  )
    }

  } */

  Container customAppBar(double deviceHeight, BuildContext context) {
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
/*

flexibleSpace: FlexibleSpaceBar(
              title: Align(
                child: Text(
                  "Anonymous",
                  style: TextStyle(fontSize: 15.0),
                ),
                alignment: Alignment.bottomLeft,
              ),
            )



body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 80.0,
            title: Text("Anonymous"),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              },
            ),
          ),
        ],
      )
*/
