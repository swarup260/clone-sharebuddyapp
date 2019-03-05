import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class MapTab extends StatefulWidget {
 @override
 _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapTab> {
 GoogleMapController mapController;

 final LatLng _center = const LatLng(45.521563, -122.677433);

 void _onMapCreated(GoogleMapController controller) {
   mapController = controller;
 }

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       appBar: AppBar(
         title: Text('Maps Sample App'),
         backgroundColor: Theme.of(context).primaryColor,
       ),
       body: GoogleMap(
         onMapCreated: _onMapCreated,
         initialCameraPosition: CameraPosition(
            target: _center,
             zoom: 11.0,
         ),
       ),
     ),
   );
 }
}