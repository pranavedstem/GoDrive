import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDataModel {
  final LatLng currentLocation;
  final String address;
  final LatLng? destination;
  final double? distance;

  LocationDataModel({
    required this.currentLocation,
    required this.address,
    this.destination,
    this.distance,
  });
}
