import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dummyprojecr/models/location_model.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  late GoogleMapController mapController;

  final ValueNotifier<LatLng> centerNotifier =
      ValueNotifier<LatLng>(const LatLng(10.007010160804644, 76.37400401568937)); // Default location
  final ValueNotifier<LocationModel?> currentLocationNotifier =
      ValueNotifier<LocationModel?>(null);

  final LatLng _endLocation = const LatLng(10.0159, 76.3419);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String address = placemarks.isNotEmpty
        ? "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}"
        : "Unknown Location";

    centerNotifier.value = LatLng(position.latitude, position.longitude);
    currentLocationNotifier.value = LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: centerNotifier.value, zoom: 12.0),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ValueListenableBuilder<LatLng>(
        valueListenable: centerNotifier,
        builder: (context, center, child) {
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 12.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('current_location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                position: center,
                infoWindow: InfoWindow(
                  title: "Your Location",
                  snippet: currentLocationNotifier.value?.address ?? "Fetching address...",
                ),
              ),
              Marker(
                markerId: const MarkerId('destination'),
                icon: BitmapDescriptor.defaultMarker,
                position: _endLocation,
              ),
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    centerNotifier.dispose();
    currentLocationNotifier.dispose();
    super.dispose();
  }
}




// Normal googlemaps


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class Maps extends StatefulWidget {
//   const Maps({super.key});

//   @override
//   MapsState createState() => MapsState();
// }

// class MapsState extends State<Maps> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(10.007010160804644, 76.37400401568937);
//   final LatLng _endlocation = const LatLng(10.0159, 76.3419);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps in Flutter'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 12.0,
//         ),
//         markers: {
//           Marker(
//             markerId: const MarkerId('destination'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _center,
            
//           ),
//           Marker(
//             markerId: const MarkerId('sourceocation'),
//             icon: BitmapDescriptor.defaultMarker,
//             position: _endlocation,
           
//           ),
//         },
//       ),
//     );
//   }
// }










// added polylines code


// import 'package:geocoding/geocoding.dart';
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

