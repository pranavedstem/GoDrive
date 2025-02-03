class RideModel {
  final String userId;
  final String rideId;
  final String startLocation;
  final String endLocation;
  final String driverName;
  final String vehicleName;
  final String vehicleNumber;
   double totalFare;
  final DateTime rideDateTime;

  RideModel({
    required this.userId,
    required this.rideId,
    required this.startLocation,
    required this.endLocation,
    required this.driverName,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.totalFare,
    required this.rideDateTime,
  });
}
