import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/GetLocation.dart';
import '../models/GetLocationList.dart';
import '../api/networkManager.dart';
import '../api/apiEndpoint.dart';
import '../widget/result_card.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Theme.of(context)
          .primaryColorDark, //or set color with: Color(0xFF0000FF)
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

class _SearchPanelState extends State<SearchPanel>
    with AutomaticKeepAliveClientMixin {
// interstitial Ad Init- Admob
  int _locationSearchCount = 0;
  AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: getInterstitialAdUnitId(),
  );

  List<Datum> locationList = List();
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
      _locationSearchCount++;
      isLoading = true;
      isSearch = true;
    });

    // interstitial Ad Load & Show - Admob
    if (_locationSearchCount > 1) {
      interstitialAd
        ..load()
        ..show();

      setState(() {
        _locationSearchCount = 0;
      });
    }

    Map<String, dynamic> myObject = {
      'from': from.toLowerCase(),
      'to': to.toLowerCase()
    };
    final response =
        await ajaxPost(getApiEndpoint(endpoint.getLocationFromTo), myObject);

    if (response != null) {
      locationList = getLocationFromJson(response).data;
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
    super.build(context);
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
                    : _checkLocationListData(locationList)),
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

  @override
  bool get wantKeepAlive => true;
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
              return ResultCard(
                object: getLocationResponse[index],
                callback: () {
                  _launchURL(
                      "google.navigation:q=${getLocationResponse[index].location.coordinates[1]},${getLocationResponse[index].location.coordinates[0]}");
                },
                // fontSize: 16.0,
                // priceSize: 25.0,
                // imageSize: 35,
              );
            })
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
/* 
resultCard(
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
              )



 */
