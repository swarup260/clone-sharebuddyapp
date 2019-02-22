import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    color: Colors.yellow,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.my_location,
                                      color: Colors.black, size: 30.0),
                                  contentPadding:
                                      EdgeInsets.only(left: 15.0, top: 15.0),
                                  hintText: 'Source',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'))),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.place,
                                      color: Colors.black, size: 30.0),
                                  contentPadding:
                                      EdgeInsets.only(left: 15.0, top: 15.0),
                                  hintText: 'Destination',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'))),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(left: 165.0, right: 0.0),
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.black,
                            child: Text("Search"),
                            onPressed: () {},
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      )
                    ],
                  )
                ],
              ),
              itemCard(),
              itemCard(),
              itemCard(),
              itemCard(),
              itemCard(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget itemCard() {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
    child: Card(
        child: Container(
      height: 120.0,
      width: double.infinity,
      padding: new EdgeInsets.only(left: 8.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                  "RAWALPADA",
                  style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                new Text(
                  "(RAWALPADA 297 BUS STOP)",
                  style: new TextStyle(color: Colors.grey),
                ),
                new Text(
                  "BORIVAI RAILWAY STATION",
                  style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.lightGreen,
                      radius: 5.0,
                    ),
                  ],
                ),
                new Text(
                  "\u20B9" + "10",
                  style: new TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                new Text(
                  "(4KM)",
                  style: new TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    )),
  );
}
