import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:sharebuddyapp/models/MyConnectivity.dart';
import 'package:sharebuddyapp/widget/network_error.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';

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
  Future<Position> currentLocation;
  GoogleMapController mapController;
  Set<Marker> markers;

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    currentLocation = getUserLoc();
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  Future<Position> getUserLoc() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.location);
    }
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        return NetworkError();
        break;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _googleMap(context),
          admodWidget(),
          FutureBuilder(
            future: locationList(5),
            builder:
                (BuildContext context, AsyncSnapshot<List<Datum>> snapshot) {
              /* if (snapshot.connectionState == ConnectionState.none) {
                return AlertDialog(
                  content: Text("Network Error."),
                );
              }

              if (snapshot.hasError) {
                return AlertDialog(
                  content: Text("Network Error."),
                );
              } */

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return buildAlign(snapshot.data);
              }
            },
          )
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(1, 0.5),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Position pos = await currentLocation;
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(pos.latitude, pos.longitude), zoom: 15.0)));
            // setState(() {});
          },
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future<List<Datum>> locationList(int distance) async {
    try {
      Position location = await currentLocation;
      var httpResponse =
          await ajaxPost(getApiEndpoint(endpoint.getLocationFromCurrent), {
        'distance': distance,
        'latitude': location.latitude,
        'longitude': location.longitude
      });
      GetLocation result = getLocationFromJson(httpResponse);
      if (result.status) {
        return result.data;
      } else {
        throw Exception("Network Error");
      }
    } catch (e) {
      throw Exception(e);
    }
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
        markers: markers,
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final result = await locationList(5);
    Position pos = await currentLocation;
    if (mounted) {
      setState(() {
        mapController = controller;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(pos.latitude, pos.longitude), zoom: 15.0)));
        markers = _markers(result);
      });
    }
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
                //imageSize: 15.0,
                iconFlag: true,
                callback: () {
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              locationList[index].location.coordinates[1],
                              locationList[index].location.coordinates[0]),
                          zoom: 20.0)));
                },
              ),
            );
          },
        ),
      ),
    );
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
