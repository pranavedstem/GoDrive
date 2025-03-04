import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  late GoogleMapController mapController;
  final ValueNotifier<LatLng> centerNotifier =
      ValueNotifier<LatLng>(const LatLng(0.0, 0.0));

  LatLng? _destination;
  final Set<Polyline> _polylines = {};
  double _distance = 0.0;
  String _address = "Fetching location...";

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

    setState(() {
      centerNotifier.value = LatLng(position.latitude, position.longitude);
      _address = address;
    });

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: centerNotifier.value, zoom: 15.0),
      ),
    );
  }

  void _onMapTapped(LatLng tappedPoint) {
    setState(() {
      _destination = tappedPoint;
      _getRoute();
    });
  }

  Future<void> _getRoute() async {
    if (_destination == null) return;

    LatLng start = centerNotifier.value;
    LatLng end = _destination!;

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=AIzaSyCiTJPWfFvwL-6mh-pz7lanrPKNKbTzvNw";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<LatLng> polylineCoordinates = [];

      if ((data["routes"] as List).isNotEmpty) {
        var route = data["routes"][0];
        var legs = route["legs"][0];
        _distance = legs["distance"]["value"] / 1000;
        print( "Distance:   $_distance");

        for (var step in legs["steps"]) {
          polylineCoordinates.add(LatLng(
            step["start_location"]["lat"],
            step["start_location"]["lng"],
          ));
          polylineCoordinates.add(LatLng(
            step["end_location"]["lat"],
            step["end_location"]["lng"],
          ));
        }
      }

      setState(() {
        _polylines.clear();
        _polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: polylineCoordinates,
        ));
      });
    } else {
      debugPrint("Error fetching route: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps - Route Finder'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<LatLng>(
            valueListenable: centerNotifier,
            builder: (context, center, child) {
              return GoogleMap(
                onMapCreated: (controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('current_location'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue),
                    position: center,
                    infoWindow:
                        InfoWindow(title: "Your Location", snippet: _address),
                  ),
                  if (_destination != null)
                    Marker(
                      markerId: const MarkerId('destination'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _destination!,
                      infoWindow: const InfoWindow(title: "Destination"),
                    ),
                },
                polylines: _polylines,
                onTap: _onMapTapped,
              );
            },
          ),
          Positioned(
            top: 80,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                _destination != null
                    ? "Distance: ${_distance.toStringAsFixed(2)} km"
                    : "Tap on map to select destination",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    centerNotifier.dispose();
    super.dispose();
  }
}
