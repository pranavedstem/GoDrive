import 'package:dummyprojecr/models/ride_model.dart';
import 'package:flutter/material.dart';


class RideBookingViewModel extends ChangeNotifier {
  late Ride ride; 
  int selectedIndex = 0;

  
  RideBookingViewModel(String start, String end) {
    ride = Ride(startLocation: start, endLocation: end);
  }

  void updateFare(int index) {
    selectedIndex = index;
    ride.totalFare = (index == 0) ? 100.0 : 200.0;
    notifyListeners();
  }

  void bookRide(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ride Booked Successfully!")));
  }

  void cancelRide(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ride Canceled!")));
  }
}