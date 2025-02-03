import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(10.007010160804644, 76.37400401568937);
  final LatLng _endlocation = const LatLng(10.0159, 76.3419);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps in Flutter'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('destination'),
            icon: BitmapDescriptor.defaultMarker,
            position: _center,
            
          ),
          Marker(
            markerId: const MarkerId('sourceocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _endlocation,
           
          ),
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';

// class Maps extends StatefulWidget {
//   const Maps({super.key});

//   @override
//   MapsState createState() => MapsState();
// }

// class MapsState extends State<Maps> {
//   late GoogleMapController mapController;
//   List<LatLng> polylineCoordinates = [];
//   Set<Polyline> polylines = {};

//   String googleApiKey = "AIzaSyCiTJPWfFvwL-6mh-pz7lanrPKNKbTzvNw";

//   @override
//   void initState() {
//     super.initState();
//     _getPolyline();
//   }

//   Future<void> _getPolyline() async {
//     PolylinePoints polylinePoints = PolylinePoints();

//     LatLng startLocation = LatLng(10.007010160804644, 76.37400401568937); 
//     LatLng endLocation = LatLng(10.0159, 76.3419); 

//     PolylineRequest request = PolylineRequest(
//       origin: PointLatLng(startLocation.latitude, startLocation.longitude),
//       destination: PointLatLng(endLocation.latitude, endLocation.longitude), mode: TravelMode.driving,
//       // Mode: TravelMode.driving,
//     );

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       request: request,
//       googleApiKey: googleApiKey,
//     );

//     if (result.points.isNotEmpty) {
//       setState(() {
//         polylineCoordinates.clear();
//         for (var point in result.points) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         }
//         polylines.add(
//           Polyline(
//             polylineId: PolylineId("route"),
//             points: polylineCoordinates,
//             color: Colors.blue,
//             width: 5,
//           ),
//         );
//       });
//     } else {
//       print("Error: ${result.errorMessage}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Google Maps Polyline")),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(36.7783, -119.4179),
//           zoom: 6,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           mapController = controller;
//         },
//         polylines: polylines,
//         markers: {
//           Marker(
//             markerId: MarkerId("start"),
//             position: LatLng(37.7749, -122.4194),
//             infoWindow: InfoWindow(title: "Start Point"),
//           ),
//           Marker(
//             markerId: MarkerId("end"),
//             position: LatLng(34.0522, -118.2437),
//             infoWindow: InfoWindow(title: "End Point"),
//           ),
//         },
//       ),
//     );
//   }
// }

