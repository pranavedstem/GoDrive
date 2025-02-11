import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  late GoogleMapController _mapController;
  final ValueNotifier<LatLng> centerNotifier =
      ValueNotifier<LatLng>(const LatLng(0.0, 0.0));
  final TextEditingController addressController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  LatLng? _destination;
  final ValueNotifier<LatLng?> destinationNotifier =
      ValueNotifier<LatLng?>(null);
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  double _distance = 0.0;
  String _currentAddress = "Fetching location...";

  GoogleMapController get mapController => _mapController;
  Set<Polyline> get polylines => _polylines;
  Set<Marker> get markers => _markers;
  double get distance => _distance;
  LatLng? get destination => _destination;
  String get currentAddress => _currentAddress;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> getCurrentLocation() async {
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
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String address = placemarks.isNotEmpty
        ? "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}"
        : "Unknown Location";

    centerNotifier.value = LatLng(position.latitude, position.longitude);
    _currentAddress = address;
    addressController.text = address;

    _updateMarkers();

    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: centerNotifier.value, zoom: 15.0),
    ));

    notifyListeners();
  }

  void onMapTapped(LatLng tappedPoint) async {
    destinationNotifier.value = tappedPoint;
    await _getAddressFromLatLng(tappedPoint);
    _updateMarkers();
    _getRoute();
  }

  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        String address =
            "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}";
        destinationController.text = address;
      }
    } catch (e) {
      destinationController.text = "Unknown Location";
    }
  }

  void _updateMarkers() {
    _markers.clear();

    _markers.add(Marker(
      markerId: const MarkerId("current_location"),
      position: centerNotifier.value,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
          InfoWindow(title: "Current Location", snippet: _currentAddress),
    ));

    if (destinationNotifier.value != null) {
      _markers.add(Marker(
        markerId: const MarkerId("destination"),
        position: destinationNotifier.value!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: "Destination", snippet: destinationController.text),
      ));
    }

    notifyListeners();
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

      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        color: Colors.blue,
        width: 5,
        points: polylineCoordinates,
      ));
    } else {
      debugPrint("Error fetching route: ${response.reasonPhrase}");
    }

    notifyListeners();
  }
}
