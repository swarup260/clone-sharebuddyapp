import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

import '../widget/result_card.dart';
import '../models/GetLocation.dart';
import '../api/apiEndpoint.dart';
import '../api/networkManager.dart';

class MapTab extends StatefulWidget {
  final Widget child;

  MapTab({Key key, this.child}) : super(key: key);

  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with AutomaticKeepAliveClientMixin {
  Location location = new Location();
  LocationData pos;
  List<Datum> locationList = [];
  Set<Marker> _markerSet = <Marker>{};

  Future<List<Datum>> getLocation(int distance) async {
    try {
      LocationData pos = await location.getLocation();

      var httpResponse = await ajaxPost(
          getApiEndpoint(endpoint.getLocationFromCurrent), {
        'distance': distance,
        'latitude': pos.latitude,
        'longitude': pos.longitude
      });
      GetLocation result = getLocationFromJson(httpResponse);
      if (result.status) {
        return result.data;
      } else {
        throw Exception("Network Error");
      }
    } catch (e) {
      throw e;
    }
  }

  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Theme.of(context)
          .primaryColorDark, //or set color with: Color(0xFF0000FF)
    ));
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _googleMap(context),
          admodWidget(),
          FutureBuilder(
            future: getLocation(5),
            initialData: locationList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return AlertDialog(
                  content: Text("Network Error"),
                );
              }
              if (snapshot.data.length > 0) {
                return buildAlign(snapshot.data);
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          )
          // buildAlign(snapshot.data)
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(1, 0.5),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            LocationData pos = await location.getLocation();
            setState(() {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(pos.latitude, pos.longitude),
                      zoom: 15.0)));
            });
          },
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget admodWidget() {
    return SafeArea(
        child: Align(
      alignment: Alignment.topCenter,
      child: AdmobBanner(
        adUnitId: getBannerAdUnitId(bannerAdType.FULL_BANNER),
        adSize: AdmobBannerSize.FULL_BANNER,
      ),
    ));
  }

  Align buildAlign(List<Datum> locationList) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: MediaQuery.of(context).size.height / 6,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 10.0,
            );
          },
          itemCount: locationList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            double cardwidth = MediaQuery.of(context).size.width * 0.7;
            return Container(
              width: cardwidth,
              child: new ResultCard(
                object: locationList[index],
                fontSize: 12.0,
                priceSize: 15.0,
                imageSize: 15.0,
                iconFlag: false,
                callback: () {
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              locationList[index].location.coordinates[1],
                              locationList[index].location.coordinates[0]),
                          zoom: 20.0,
                          tilt: 30.0)));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(19.0760, 72.8777), zoom: 15),
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        rotateGesturesEnabled: true,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        markers: _markerSet,
      ),
    );
  }

  /* _omMapCreated Controller  */
  Future<void> _onMapCreated(GoogleMapController controller) async {
    LocationData pos = await location.getLocation();
    List<Datum> results = await getLocation(5);
    setState(() {
      mapController = controller;
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(pos.latitude, pos.longitude), zoom: 15.0)));
      _markerSet = _markers(results);
    });
  }

  Set<Marker> _markers(List<Datum> locationList) {
    Set<Marker> markerSet = <Marker>{};

    locationList.forEach((value) {
      markerSet.add(Marker(
          markerId: MarkerId(value.id.toString()),
          position: LatLng(
              value.location.coordinates[1], value.location.coordinates[0]),
          infoWindow: InfoWindow(title: value.landmark),
          icon: BitmapDescriptor.fromAsset(value.type == 'auto'
              ? 'assets/images/auto_100.png'
              : 'assets/images/taxi_150.png'),
          onTap: () {
            _launchURL(
                "google.navigation:q=${value.location.coordinates[1]},${value.location.coordinates[0]}");
          }));
    });
    return markerSet;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  bool get wantKeepAlive => true;
}
