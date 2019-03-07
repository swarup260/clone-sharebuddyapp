import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor:
          Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                          padding: EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Center(
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.black,
                                child: Text("Search"),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                itemCard(
                    'RAWALPADA',
                    'BORIVAI RAILWAY STATION',
                    '(RAWALPADA 297 BUS STOP)',
                    '10',
                    '(4KM)',
                    'assets/images/auto.png'),
                itemCard('MINDSPACE MALAD', 'MADAL RAILWAY STATION',
                    '(INTERFACE 16)', '12', '(5KM)', 'assets/images/taxi.png'),
                itemCard(
                    'BORIVAI RAILWAY STATION',
                    'RAWALPADA',
                    '(BORIVALI 297 BUS STOP)',
                    '15',
                    '(4KM)',
                    'assets/images/auto.png'),
                itemCard(
                    'RAWALPADA',
                    'BORIVAI RAILWAY STATION',
                    '(RAWALPADA 297 BUS STOP)',
                    '10',
                    '(4KM)',
                    'assets/images/auto.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemCard(from, to, landmark, price, kilometer, type) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
    child: Card(
        child: Container(
      height: 120.0,
      width: double.infinity,
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    from,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.swap_vert),
                      Text(
                        landmark,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "\u20B9" + price,
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    kilometer,
                    style: TextStyle(color: Colors.grey),
                  ),
                  //Icon(Icons.local_taxi),
                  Image.asset(
                    type,
                    width: 35,
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsets.only(top: 5.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Icon(
                  //   Icons.check_circle,
                  //   color: Colors.green,
                  //   size: 15.0,
                  // )
                  CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    radius: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )),
  );
}
