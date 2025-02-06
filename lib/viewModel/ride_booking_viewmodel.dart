import 'package:flutter/material.dart';
import 'package:dummyprojecr/models/ride_model.dart';
import 'package:dummyprojecr/models/ride_type_model.dart';

class RideBookingViewModel extends ChangeNotifier {
  RideModel _ride = RideModel(
    userId: "USR12345",
    rideId: "RIDE67890",
    startLocation: "Infopark Phase 2, Kakkanad",
    endLocation: "LULU Mall, Edappally",
    driverName: "Joyal",
    vehicleName: "Maruti Suzuki Swift Dezire",
    vehicleNumber: "KL 08 AZ 9891",
    totalFare: 255,
    rideDateTime: DateTime.now(),
  );

  List<RideType> rideTypes = [
    RideType(type: "Economy", baseFare: 255),
    RideType(type: "Premium", baseFare: 380),
  ];

  int _selectedIndex = 0;

  RideModel get ride => _ride;
  int get selectedIndex => _selectedIndex;

  void updateFare(int index) {
    _selectedIndex = index;
    _ride = RideModel(
      userId: _ride.userId,
      rideId: _ride.rideId,
      startLocation: _ride.startLocation,
      endLocation: _ride.endLocation,
      driverName: _ride.driverName,
      vehicleName: _ride.vehicleName,
      vehicleNumber: _ride.vehicleNumber,
      totalFare: rideTypes[index].baseFare,
      rideDateTime: _ride.rideDateTime,
    );
    notifyListeners();
  }

  void bookRide(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ride Booked Successfully!")),
    );
  }

  void cancelRide(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ride Cancelled!")),
    );
  }
}
