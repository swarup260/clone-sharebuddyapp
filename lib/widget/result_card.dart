/* Search Result Card */
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final Widget child;
  var object;
  final double fontSize;
  final double imageSize;
  final double priceSize;
  final bool iconFlag;
  final double containerHeight;
  final double containerWidth;
  Function callback;
  ResultCard(
      {Key key,
      this.child,
      this.object,
      this.fontSize = 16.0,
      this.imageSize = 35.0,
      this.priceSize = 25.0,
      this.iconFlag = true,
      this.containerHeight,
      this.containerWidth,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: buildPadding(),
      onTap: callback,
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
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
                      object.from.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.swap_vert),
                        Text(
                          object.landmark.toUpperCase(),
                          style: TextStyle(color: Colors.grey, fontSize: 11.0),
                        ),
                      ],
                    ),
                    Text(
                      object.to.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
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
                      "\u20B9" + object.price,
                      style: TextStyle(
                          color: object.verified
                              ? Colors.lightGreen
                              : Colors.redAccent,
                          fontSize: priceSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      object.kilometer + " KM",
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                    // Icon(Icons.local_taxi),
                    if (iconFlag)
                      Image.asset(
                        object.type == "auto"
                            ? 'assets/images/auto.png'
                            : 'assets/images/taxi.png',
                        width: imageSize,
                        height: imageSize,
                      )
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
                      backgroundColor: object.verified
                          ? Colors.lightGreen
                          : Colors.redAccent,
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
}

Widget resultCard(String from, String to, String landmark, String price,
    String kilometer, String type, Color verified) {
  return Padding(
    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
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
                        color: verified,
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
                    backgroundColor: verified,
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
