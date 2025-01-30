import 'package:flutter/material.dart';
import 'package:dummyprojecr/models/ride_model.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  RideBookingScreenState createState() => RideBookingScreenState();
}

class RideBookingScreenState extends State<RideBookingScreen> {
  // Sample ride data
  RideModel ride = RideModel(
    userId: "USR12345",
    rideId: "RIDE67890",
    startLocation: "Infopark Phase 2, kakkanad",
    endLocation: "LULU Mall ,Edappally",
    driverName: "Joyal",
    vehicleName: "Maruti Suzuki Swift dezire",
    vehicleNumber: "KL 08 AZ 9891",
    totalFare: 255,
    rideDateTime: DateTime.now(),
  );

  void bookRide() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Ride Booked Successfully!")),
    );
  }

  void cancelRide() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Ride Cancelled!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ride Booking")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoTile("Starting Location", ride.startLocation),
              buildInfoTile("Ending Location", ride.endLocation),
              buildInfoTile("User ID", ride.userId),
              buildInfoTile("Ride ID", ride.rideId),
              buildInfoTile("Driver Name", ride.driverName),
              buildInfoTile("Vehicle", "${ride.vehicleName} (${ride.vehicleNumber})"),
              buildInfoTile("Total Fare", "\$${ride.totalFare.toStringAsFixed(2)}"),
              buildInfoTile("Date & Time", ride.rideDateTime.toString()),
              
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: bookRide,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Book Ride"),
                  ),
                  ElevatedButton(
                    onPressed: cancelRide,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Cancel Ride"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
