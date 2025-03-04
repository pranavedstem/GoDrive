import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dummyprojecr/viewModel/ride_booking_viewmodel.dart';

class RideBookingScreen extends StatelessWidget {
  final String startLocation;
  final String endLocation;

  const RideBookingScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RideBookingViewModel(startLocation, endLocation),
      child: Scaffold(
        appBar: AppBar(title: const Text("Ride Booking")),
        body: Consumer<RideBookingViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoTile("Starting Location", viewModel.ride.startLocation),
                    buildInfoTile("Ending Location", viewModel.ride.endLocation),
                    buildInfoTile("User ID", viewModel.ride.userId),
                    buildInfoTile("Ride ID", viewModel.ride.rideId),
                    buildInfoTile("Driver Name", viewModel.ride.driverName),
                    buildInfoTile("Vehicle", "${viewModel.ride.vehicleName} (${viewModel.ride.vehicleNumber})"),
                    
                    const SizedBox(height: 15),
                    const Text("Select Ride Type:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: const Color.fromARGB(255, 19, 88, 216),
                      isSelected: [viewModel.selectedIndex == 0, viewModel.selectedIndex == 1],
                      onPressed: viewModel.updateFare,
                      children: const [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Economy")),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Premium")),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Fare:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          "Rs. ${viewModel.ride.totalFare.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => viewModel.bookRide(context,),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text("Book Ride"),
                        ),
                        ElevatedButton(
                          onPressed: () => viewModel.cancelRide(context),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text("Cancel Ride"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value.isNotEmpty ? value : "Not Available"),
      ),
    );
  }
}
