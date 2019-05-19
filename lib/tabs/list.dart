import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/GetLocation.dart';
import '../models/networkManager.dart';

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
  bool fromValidate = false;
  bool toValidate = false;
  String from = "";
  String to = "";

  final TextEditingController fromController = new TextEditingController();
  final TextEditingController toController = new TextEditingController();

  _fetchData() async {
    setState(() {
      from.isEmpty ? fromValidate = true : fromValidate = false;
      to.isEmpty ? toValidate = true : toValidate = false;
      isLoading = true;
    });
    if (from.isEmpty || to.isEmpty) {
      isLoading = false;
      return false;
    }
    Map<String, dynamic> myObject = {'from': from, 'to': to} ;

    final response = await ajaxPost('location/getLocationFromTo',myObject);

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new GetLocation.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 220.0,
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
                    errorText: fromValidate ? 'Please Select Source.' : null,
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
                    errorText: toValidate ? 'Please Select Destination.' : null,
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
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).indicatorColor),
                      ),
                    )
                  : list.length > 0
                      ? SearchResultPanel(getLocationResponse: list)
                      : Center(
                          child: Text("No Data Found."),
                        ),
            ),
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
            physics: ClampingScrollPhysics(),
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
