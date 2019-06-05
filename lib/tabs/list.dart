import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:admob_flutter/admob_flutter.dart';

import '../models/GetLocation.dart';
import '../models/GetLocationList.dart';
import '../api/networkManager.dart';
import '../api/apiEndpoint.dart';

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
  List<GetLocation> locationList = List();
  List locationNameList = List();

  var isLoading = false;
  var isSearch = false;

  String from = "";
  String to = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fromController = new TextEditingController();
  final TextEditingController toController = new TextEditingController();

  // Fetch data from api
  _fetchData() async {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
    } else {
      return false;
    }

    setState(() {
      isLoading = true;
      isSearch = true;
    });

    Map<String, dynamic> myObject = {
      'from': from.toLowerCase(),
      'to': to.toLowerCase()
    };
    final response =
        await ajaxPost(getApiEndpoint(endpoint.getLocationFromTo), myObject);

    if (response != null) {
      locationList = getLocationFromJson(response);
      setState(() {
        isLoading = false;
        if (locationList.length > 0) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Total Number of Results: ${locationList.length}',
                  textAlign: TextAlign.center)));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content:
                  Text('No Direct Route Found.', textAlign: TextAlign.center)));
        }
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load data', textAlign: TextAlign.center)));
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Form(
                key: this._formKey,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      // Source TextBox
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this.fromController,
                          decoration: InputDecoration(
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //      setState(() {this.fromController.clear(); });
                            //   },
                            //   icon: Icon(
                            //     Icons.clear,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(20.0)),
                            // ),
                            filled: true,
                            prefixIcon: Icon(Icons.my_location,
                                color: Colors.black, size: 25.0),
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Source',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Quicksand'),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.length > 2) {
                            Map<String, dynamic> myObject = {
                              'key': 'from',
                              'search': pattern
                            };

                            final response = await ajaxPost(
                                getApiEndpoint(endpoint.getLocationList),
                                myObject);
                            locationNameList =
                                getLocationListFromJson(response);
                            return locationNameList;
                          }
                        },
                        itemBuilder: (context, suggestion) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    '${suggestion[0].toUpperCase()}${suggestion.substring(1)}'),
                              ),
                              Divider(
                                height: 0.0,
                              ),
                            ],
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this.fromController.text =
                              '${suggestion[0].toUpperCase()}${suggestion.substring(1)}';
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Select Source';
                          }
                          if (value.length < 5) {
                            return 'Please Selete Source from list';
                          }
                        },
                        onSaved: (value) => this.from = value,
                      ),

                      SizedBox(height: 5.0),

                      //Destination TextBox
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this.toController,
                          decoration: InputDecoration(
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //      setState(() {this.toController.clear(); });
                            //   },
                            //   icon: Icon(
                            //     Icons.clear,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(20.0)),
                            // ),
                            filled: true,
                            prefixIcon: Icon(Icons.place,
                                color: Colors.black, size: 25.0),
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Destination',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Quicksand'),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.length > 2) {
                            Map<String, dynamic> myObject = {
                              'key': 'to',
                              'search': pattern
                            };

                            final response = await ajaxPost(
                                getApiEndpoint(endpoint.getLocationList),
                                myObject);
                            locationNameList =
                                getLocationListFromJson(response);
                            return locationNameList;
                          }
                        },
                        itemBuilder: (context, suggestion) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    '${suggestion[0].toUpperCase()}${suggestion.substring(1)}'),
                              ),
                              Divider(
                                height: 0.0,
                              ),
                            ],
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this.toController.text =
                              '${suggestion[0].toUpperCase()}${suggestion.substring(1)}';
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Select Destination';
                          }
                          if (value.length < 5) {
                            return 'Please Selete Destination from list';
                          }
                        },
                        onSaved: (value) => this.to = value,
                      ),

                      SizedBox(height: 10.0),

                      //Search Button
                      ButtonTheme(
                          minWidth: 130,
                          height: 43,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.black,
                            child: Text("Search"),
                            onPressed: _fetchData,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            AdmobBanner(
              adUnitId: getBannerAdUnitId(bannerAdType.FULL_BANNER),
              adSize: AdmobBannerSize.FULL_BANNER,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 0.0),
              child: isLoading
                  ? Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).indicatorColor),
                      ),
                    )
                  : _checkLocationListData(locationList),
            ),
          ],
        ),
      ],
    );
  }

  Widget _checkLocationListData(locationList) {
    if (locationList.length > 0) {
      return SearchResultPanel(getLocationResponse: locationList);
    } else {
      if (isSearch) {
        return Center(
          heightFactor: 5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.not_listed_location,
                size: 30.0,
              ),
              Text(
                "No Direct Route Found.",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        );
      } else {
        //Adsense Code
      }
    }
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
                getLocationResponse[index].from.toUpperCase(),
                getLocationResponse[index].to.toUpperCase(),
                getLocationResponse[index].landmark.toUpperCase(),
                getLocationResponse[index].price,
                getLocationResponse[index].kilometer + " KM",
                getLocationResponse[index].type == "auto"
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
