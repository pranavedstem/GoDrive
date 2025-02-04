import 'package:dummyprojecr/models/reide_type_model.dart';
import 'package:flutter/material.dart';
import 'package:dummyprojecr/models/ride_model.dart';


class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  RideBookingScreenState createState() => RideBookingScreenState();
}

class RideBookingScreenState extends State<RideBookingScreen> {
  RideModel ride = RideModel(
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

 
  final List<RideType> rideTypes = [
    RideType(type: "Economy", baseFare: 255),
    RideType(type: "Premium", baseFare: 380),
  ];

  int selectedIndex = 0; 

  void updateFare(int index) {
    setState(() {
      selectedIndex = index;
      ride = RideModel( 
        userId: ride.userId,
        rideId: ride.rideId,
        startLocation: ride.startLocation,
        endLocation: ride.endLocation,
        driverName: ride.driverName,
        vehicleName: ride.vehicleName,
        vehicleNumber: ride.vehicleNumber,
        totalFare: rideTypes[index].baseFare,
        rideDateTime: ride.rideDateTime,
      );
    });
  }

  void bookRide() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ride Booked Successfully!")),
    );
  }

  void cancelRide() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ride Cancelled!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Booking")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoTile("Starting Location", ride.startLocation),
              buildInfoTile("Ending Location", ride.endLocation),
              buildInfoTile("User ID", ride.userId),
              buildInfoTile("Ride ID", ride.rideId),
              buildInfoTile("Driver Name", ride.driverName),
              buildInfoTile("Vehicle", "${ride.vehicleName} (${ride.vehicleNumber})"),
              
              const SizedBox(height: 10),

              
              const Text("Select Ride Type:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: const Color.fromARGB(255, 19, 88, 216),
                isSelected: [selectedIndex == 0, selectedIndex == 1],
                onPressed: updateFare,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Economy"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Premium"),
                  ),
                ],
              ),

              const SizedBox(height: 15),

             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Fare:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Rs. ${ride.totalFare.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: bookRide,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Book Ride"),
                  ),
                  ElevatedButton(
                    onPressed: cancelRide,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Cancel Ride"),
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
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:dummyprojecr/models/ride_model.dart';

// class RideBookingScreen extends StatefulWidget {
//   const RideBookingScreen({super.key});

//   @override
//   RideBookingScreenState createState() => RideBookingScreenState();
// }

// class RideBookingScreenState extends State<RideBookingScreen> {
//   RideModel ride = RideModel(
//     userId: "USR12345",
//     rideId: "RIDE67890",
//     startLocation: "Infopark Phase 2, kakkanad",
//     endLocation: "LULU Mall ,Edappally",
//     driverName: "Joyal",
//     vehicleName: "Maruti Suzuki Swift dezire",
//     vehicleNumber: "KL 08 AZ 9891",
//     totalFare: 255,
//     rideDateTime: DateTime.now(),
//   );

//   void bookRide() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Ride Booked Successfully!")),
//     );
//   }

//   void cancelRide() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Ride Cancelled!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Ride Booking")),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildInfoTile("Starting Location", ride.startLocation),
//               buildInfoTile("Ending Location", ride.endLocation),
//               buildInfoTile("User ID", ride.userId),
//               buildInfoTile("Ride ID", ride.rideId),
//               buildInfoTile("Driver Name", ride.driverName),
//               buildInfoTile(
//                   "Vehicle", "${ride.vehicleName} (${ride.vehicleNumber})"),
//               buildInfoTile(
//                   "Total Fare", "\$${ride.totalFare.toStringAsFixed(2)}"),
//               buildInfoTile("Date & Time", ride.rideDateTime.toString()),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: bookRide,
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     child: Text("Book Ride"),
//                   ),
//                   ElevatedButton(
//                     onPressed: cancelRide,
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     child: Text("Cancel Ride"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildInfoTile(String title, String value) {
//     return Card(
//       // elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 3),
//       child: ListTile(
//         title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(value),
//       ),
//     );
//   }
// }
