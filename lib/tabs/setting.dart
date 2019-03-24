import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingTab extends StatefulWidget {
  final Widget child;

  SettingTab({Key key, this.child}) : super(key: key);

  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  Map<String, Icon> settingIcon = {
    'Recieve Notification': Icon(Icons.notifications),
    'Login': Icon(FontAwesomeIcons.userAlt)
  };
  Map<String, Icon> settingAboutUsIcon = {
    'Send Us Feedback': Icon(Icons.feedback),
    'App Info': Icon(Icons.info),
    'About Us': Icon(FontAwesomeIcons.infoCircle),
    'Help Us': Icon(FontAwesomeIcons.handsHelping),
    'Rate Us': Icon(Icons.rate_review)
  };

  List monthsOfTheYear = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: fixedExtentScrollController,
      physics: FixedExtentScrollPhysics(),
      children: monthsOfTheYear.map((month) {
        return Card(
            child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                month,
                style: TextStyle(fontSize: 18.0),
              ),
            )),
          ],
        ));
      }).toList(),
      itemExtent: 60.0,
    );
  }

  Center buildCenter() {
    return Center(
      child: Padding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                FontAwesomeIcons.user,
                size: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'HELLO USER',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Flexible(
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: settingIcon.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildContainer(settingIcon, index);
                  },
                ),
                elevation: 4.0,
              ),
            ),
            Flexible(
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: settingAboutUsIcon.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildContainer(settingAboutUsIcon, index);
                  },
                ),
                elevation: 4.0,
              ),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 30.0),
      ),
    );
  }

  Container buildContainer(Map map, int index) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: map.values.toList()[index],
        ),
        Expanded(
          child: InkWell(
            child: Padding(
              child: Text(
                map.keys.toList()[index],
                style: TextStyle(fontSize: 15.0),
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 15.0),
            ),
            onTap: () {
              print('object');
            },
          ),
          flex: 2,
        ),
      ],
    ));
  }
}

/* 

InkWell(
          child: Padding(
            child: Text(
              setting[index],
              style: TextStyle(fontSize: 15.0),
            ),
            padding: EdgeInsets.all(10),
          ),
          onTap: () {
            print('object');
          },
        )

 */
