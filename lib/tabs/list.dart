import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/GetLocation.dart';

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
            SearchPanel(),
            //SearchResultPanel(),
          ],
        ),
      ),
    );
  }
}

/* Search Section */

class SearchPanel extends StatefulWidget {
  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  List<GetLocation> list = List();
  var isLoading = false;
  bool _validate = false;
  String from = "";
  String to = "";

  final TextEditingController fromController = new TextEditingController();
  final TextEditingController toController = new TextEditingController();

  _fetchData() async {
    setState(() {
      from.isEmpty ? _validate = true : _validate = false;
      isLoading = true;
    });

    final response = await http.post(
      "https://sharing-point-dev.herokuapp.com/location/getLocationFromTo",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.NykEM4bbRJYDCkP84ExLGhOkqBkDCe-avND2YoHXOFY",
      },
      body: ({"from": from, "to": to}),
    );
    if (response.statusCode == 200) {
      print(response.body);
      list = (json.decode(response.body) as List)
          .map((data) => new GetLocation.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                child: TextField(
                  controller: fromController,
                  onChanged: (String text) {
                    from = text;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.my_location,
                        color: Colors.black, size: 30.0),
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    hintText: 'Source',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),
                    errorText: _validate ? 'Please Select Source.' : null,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
                child: TextField(
                  controller: toController,
                  onChanged: (String text) {
                    to = text;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        Icon(Icons.place, color: Colors.black, size: 30.0),
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    hintText: 'Destination',
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: 'Quicksand'),
                    errorText: _validate ? 'Please Select Destination.' : null,
                  ),
                ),
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
                    onPressed: _fetchData,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SearchResultPanel(getLocationResponse: list),
          ],
        ),
      ],
    );
  }
}

/* Result Section */
class SearchResultPanel extends StatelessWidget {
  final List getLocationResponse;
  SearchResultPanel({Key key, @required List getLocationResponse})
      : getLocationResponse = getLocationResponse,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: getLocationResponse.length,
            itemBuilder: (BuildContext context, int index) {
              return resultCard(
                getLocationResponse[index].from,
                getLocationResponse[index].to,
                getLocationResponse[index].landmark,
                getLocationResponse[index].price,
                getLocationResponse[index].kilometer + " KM",
                getLocationResponse[index].type == "Auto"
                    ? 'assets/images/auto.png'
                    : 'assets/images/taxi.png',
                getLocationResponse[index].verified
                    ? Colors.lightGreen
                    : Colors.redAccent,
              );
            })
      ],
    );
  }
}

/* Search Result Card */
Widget resultCard(from, to, landmark, price, kilometer, type, verified) {
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
