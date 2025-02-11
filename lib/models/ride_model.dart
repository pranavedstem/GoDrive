class Ride {
  String startLocation;
  String endLocation;
  String userId;
  String rideId;
  String driverName;
  String vehicleName;
  String vehicleNumber;
  double totalFare;

  Ride({
    required this.startLocation,
    required this.endLocation,
    this.userId = "12345",
    this.rideId = "RIDE-67890",
    this.driverName = "Pranav",
    this.vehicleName = "Toyota Prius",
    this.vehicleNumber = "XYZ 1234",
    this.totalFare = 100.0, 
  });
}