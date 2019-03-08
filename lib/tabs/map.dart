import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_buddy/models/pointLocation.dart';
import 'package:location/location.dart' as LocationManager;

class MapTab extends StatelessWidget {
 @override
 Widget build(BuildContext context){
   return new Scaffold(
     body: new GoogleMaps(),
   );
 }
}

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMaps createState() => new _GoogleMaps();

}

class _GoogleMaps extends State<GoogleMaps> {

  GoogleMapController mapController;

  List<PointLocation> pointsList = List<PointLocation>();       //points array

  final LatLng _center = const LatLng(19.0760, 72.8777);

  
  ///Array of points, [pointsList] to display markers on the map
  ///
  @override 
  void initState() {
    var point = PointLocation(
      idPoint: 1,
      namePoint: 'Powai',
      lat: 19.1197,
      long: 72.9051,
      landmark: 'Nearby IITBombay',
      fare: 20
    );
    pointsList.add(point);
    point = PointLocation(
      idPoint: 2,
      namePoint: 'Ghatkopar',
      lat: 19.0790,
      long: 72.9080,
      landmark: 'Nearby RCity Mall',
      fare: 20
    );
    pointsList.add(point);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var mq =MediaQuery.of(context);
    return Center(
      child: SizedBox(
        width: mq.size.width,
        height: mq.size.height,
        ///
        ///Add Map to the screen with points on it.
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
             zoom: 11.0,
         ),
         markers: _addMarkers(),

        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      refresh();
    });
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    //getNearbyPlaces(center);
  }

  /// Get the current location of the device.
  /// 
  Future<LatLng> getUserLocation() async {
  var currentLocation = <String, double>{};
  final location = LocationManager.Location();
  try {
    currentLocation = (await location.getLocation()) as Map<String, double>;
    final lat = currentLocation["latitude"];
    final lng = currentLocation["longitude"];
    final center = LatLng(lat, lng);
    return center;
    } on Exception {
      currentLocation = null;
      return null;
    } 
  }

  ///Set of Points for markers on map.
  ///
  Set<Marker> _addMarkers() {
    Set<Marker> markerSet = <Marker>{};
    pointsList.forEach((loc) {
      markerSet.add(Marker(
        markerId: MarkerId(loc.idPoint.toString()),
        position: LatLng(loc.lat, loc.long),
        infoWindow: InfoWindow(title: loc.namePoint + ', ' + loc.landmark),
        visible: true
      ));
    });

    return markerSet;
  }


}
