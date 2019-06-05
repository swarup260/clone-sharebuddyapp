import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share_buddy/widget/result_card.dart';
import '../models/GetLocation.dart';
import '../api/apiEndpoint.dart';
import '../api/networkManager.dart';

class MapTab extends StatefulWidget {
  final Widget child;

  MapTab({Key key, this.child}) : super(key: key);

  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  Location location = new Location();

  List<Datum> locationList = [];

  // void initState() {
  //   super.initState();
  //   // LocationData pos = await location.getLocation();
  //   // final result = ajaxPost(getApiEndpoint(endpoint.getLocationFromCurrent),
  //   //     {'distance': 5, 'latitude': pos.latitude, 'longitude': pos.longitude});
  //   // print(result);
  // }

  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor:
          Theme.of(context).primaryColorDark, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _googleMap(context),
            Align(
              alignment: Alignment.topLeft,
              child: AdmobBanner(
                adUnitId: getBannerAdUnitId(bannerAdType.BANNER),
                adSize: AdmobBannerSize.BANNER,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 80.0,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10.0,
                    );
                  },
                  itemCount: locationList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 25.0,
                      width: 250.0,
                      child: new ResultCard(
                        object: locationList[index],
                        fontSize: 10.0,
                        priceSize: 15.0,
                        imageSize: 15.0,
                        iconFlag: false,
                        callback: () {
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      locationList[index]
                                          .location
                                          .coordinates[1],
                                      locationList[index]
                                          .location
                                          .coordinates[0]),
                                  zoom: 20.0,
                                  tilt: 30.0)));
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
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
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        markers: _markers(),
      ),
    );
  }

  /* _omMapCreated Controller  */
  void _onMapCreated(GoogleMapController controller) async {
    LocationData pos = await location.getLocation();
    try {
      final result = await ajaxPost(
          getApiEndpoint(endpoint.getLocationFromCurrent), {
        'distance': 5,
        'latitude': pos.latitude,
        'longitude': pos.longitude
      });
      locationList = getLocationFromJson(result).data;
    } catch (e) {
      /* network error code */
    }
    setState(() {
      mapController = controller;
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(pos.latitude, pos.longitude), zoom: 15.0)));
    });
  }

  /* tesing the Markers */
  Set<Marker> _markers() {
    Set<Marker> markerSet = <Marker>{};

    locationList.forEach((value) {
      markerSet.add(Marker(
          markerId: MarkerId(value.id.toString()),
          position: LatLng(
              value.location.coordinates[1], value.location.coordinates[0]),
          infoWindow: InfoWindow(title: value.landmark),
          icon: BitmapDescriptor.fromAsset('assets/images/taxi.png')));
    });
    return markerSet;
  }
}
