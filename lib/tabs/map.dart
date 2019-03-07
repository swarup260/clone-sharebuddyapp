import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_buddy/models/pointLocation.dart';


// class MapTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: Center(
//         child: Text('Welcome to Map'),
//       ),
//     );
//   }
// }

class MapTab extends StatelessWidget {
 @override
 Widget build(BuildContext context){
   return new Scaffold(
     body: new GoogleMaps(),
   );
 }
 //_MyAppState createState() => _MyAppState();
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

  //
  //Static array of points to display markers on the map
  //
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
    });
  }

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
// class _MyAppState extends State<MapTab> {
//  GoogleMapController mapController;

//  final LatLng _center = const LatLng(45.521563, -122.677433);

//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Maps Sample App'),
//          backgroundColor: Theme.of(context).primaryColor,
//        ),
//        body: GoogleMap(
//          onMapCreated: _onMapCreated,
//          initialCameraPosition: CameraPosition(
//             target: _center,
//              zoom: 11.0,
//          ),
//        ),
//      ),
//    );
//  }
// }