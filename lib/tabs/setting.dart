import 'package:flutter/material.dart';
import 'package:share_buddy/tabs/screens/about_us.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingTab extends StatelessWidget {
  List<Widget> _list = [
    ReceiveNotification(),
    SettingField(label_name: 'Send Feedback'),
    SettingField(label_name: 'Rate Us'),
    SettingField(label_name: 'About Us'),
    SettingField(
      label_name: 'Follow Us',
    ),
    Share()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedSetting(list: _list),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({
    Key key,
    @required List<String> list,
  })  : _list = list,
        super(key: key);

  final List<String> _list;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: true,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              child: Text(
                'Anonymous',
                style: TextStyle(letterSpacing: 1),
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              tooltip: 'User',
              onPressed: () {},
            )
          ],
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Padding(
              child: Container(
                child: Text(
                  _list[index],
                  style: TextStyle(fontSize: 20),
                ),
              ),
              padding: EdgeInsets.all(10),
            );
          }, childCount: 5),
        ),
      ],
    );
  }
}

class NestedSetting extends StatelessWidget {
  final List<Widget> _list;
  NestedSetting({
    Key key,
    @required List<Widget> list,
  })  : _list = list,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(10),
                title: Text('Anonymous'),
              ),
              actions: <Widget>[
                Padding(
                  child: PopupMenuButton(
                    child: Icon(Icons.person),
                    onCanceled: () {},
                    tooltip: 'User',
                    itemBuilder: (BuildContext context) {
                      return Choices.choices
                          .map((String choices) => PopupMenuItem<String>(
                                value: choices,
                                child: Text(choices),
                              ))
                          .toList();
                    },
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ],
            )
          ];
        },
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              return _list[index];
            },
          ),
        ));
  }
}

class ReceiveNotification extends StatefulWidget {
  final Widget child;

  ReceiveNotification({Key key, this.child}) : super(key: key);

  _ReceiveNotificationState createState() => _ReceiveNotificationState();
}

class _ReceiveNotificationState extends State<ReceiveNotification> {
  @override
  bool enabled = false;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Padding(
            child: Text(
              'Receive Notification',
              style: TextStyle(fontSize: 18),
            ),
            padding: EdgeInsets.all(10),
          ),
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
    );
  }
}

class Share extends StatelessWidget {
  final Widget child;

  Share({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Padding(
            child: Text(
              'Share',
              style: TextStyle(fontSize: 18),
            ),
            padding: EdgeInsets.all(10),
          ),
        ),
        Flexible(
          child: GestureDetector(
            child: Padding(
              child: Icon(Icons.share),
              padding: EdgeInsets.all(10),
            ),
            onTap: () {},
          ),
        )
      ],
    );
  }
}

class SettingField extends StatelessWidget {
  final String label_name;
  SettingField({Key key, @required String label_name})
      : label_name = label_name,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Function onTap2 = () {
      switch (label_name) {
        case 'Send Feedback':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1))),

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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1))),

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
          break;
        case 'Rate Us':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Icon(Icons.star),
                  actions: <Widget>[
                    FlatButton(
                      child: Icon(Icons.check_circle),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          break;
        case 'About Us':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new AboutUsPage()));
          break;
        case 'Follow Us':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.facebook,
                        size: 40,
                        color: Colors.blue,
                      ),
                      Icon(
                        FontAwesomeIcons.twitter,
                        size: 40,
                        color: Colors.lightBlue,
                      ),
                      Icon(
                        FontAwesomeIcons.google,
                        size: 40,
                        color: Colors.red,
                      ),
                      Icon(
                        FontAwesomeIcons.instagram,
                        size: 40,
                        color: Colors.pink,
                      )
                    ],
                  ),
                );
              });
          break;
        default:
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('tap working'),
          ));
      }
    };
    return GestureDetector(
      child: Padding(
        child: Container(
          child: Text(
            label_name,
            style: TextStyle(fontSize: 18),
          ),
        ),
        padding: EdgeInsets.all(10),
      ),
      onTap: onTap2,
    );
  }
}

// Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Container(
//             child: Text(
//               'Receive Notification',
//               style: TextStyle(fontSize: 20),
//             ),
//             height: 30,
//           ),
//           Switch(
//             value: enabled,
//             onChanged: (bool enabled) {
//               setState(() {
//                 enabled = true;
//               });
//             },
//           )
//         ],
//       )

/* choices  */

class Choices {
  static const String login = "Login";
  static const String register = "register";

  static const List<String> choices = [login, register];
}
