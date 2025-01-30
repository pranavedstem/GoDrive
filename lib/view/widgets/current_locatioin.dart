// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:dummyprojecr/view/screens/home_screen.dart';


// class CurrentLocation extends StatefulWidget {
//   const CurrentLocation({super.key});

//   @override
//   CurrentLocationState createState() => CurrentLocationState();
// }

// class CurrentLocationState extends State<CurrentLocation> {
//   bool _isFetching = false;

//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       _isFetching = true;
//     });

//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() => _isFetching = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Location services are disabled.")),
//       );
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() => _isFetching = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Location permission is denied.")),
//         );
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() => _isFetching = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Location permission is permanently denied.")),
//       );
//       return;
//     }

//     // Get the current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     // Convert coordinates to address
//     String address = await _getAddressFromLatLng(position.latitude, position.longitude);

//     setState(() {
//       _isFetching = false;
//     });

//     // Navigate to Next Page with Address
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Home(address: address),
//       ),
//     );
//   }

//   // Function to convert latitude and longitude into a readable address
//   Future<String> _getAddressFromLatLng(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       Placemark place = placemarks.first;

//       return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//     } catch (e) {
//       return "Unknown Address";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Get Current Location')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _isFetching ? null : _getCurrentLocation,
//           child: _isFetching
//               ? CircularProgressIndicator(color: Colors.white)
//               : Text('Get Location'),
//         ),
//       ),
//     );
//   }
// }
