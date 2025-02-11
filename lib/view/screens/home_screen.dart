import 'package:dummyprojecr/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dummyprojecr/view/screens/ride_booking.dart';

class Home extends StatelessWidget {
  final HomeViewModel viewModel;

  const Home({super.key, required this.viewModel, required String address});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<LatLng?>(
          valueListenable: viewModel.destinationNotifier,
          builder: (context, destination, child) {
            return GoogleMap(
              onMapCreated: viewModel.setMapController,
              initialCameraPosition: CameraPosition(
                  target: viewModel.centerNotifier.value, zoom: 15.0),
              markers: {
                Marker(
                  markerId: MarkerId('current_location'),
                  position: viewModel.centerNotifier.value,
                  infoWindow: InfoWindow(title: "Your Location"),
                ),
                if (destination != null)
                  Marker(
                    markerId: MarkerId('destination'),
                    position: destination,
                    infoWindow: InfoWindow(title: "Destination"),
                  ),
              },
              polylines: viewModel.polylines,
              onTap: viewModel.onMapTapped,
            );
          },
        ),
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(
                  color: Color.fromARGB(255, 117, 116, 116), width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: viewModel.addressController,
                    decoration: const InputDecoration(
                      labelText: 'Current Location',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: viewModel.destinationController,
                    decoration: const InputDecoration(
                      hintText: 'Where to?',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 16,
          child: FloatingActionButton(
            onPressed: viewModel.getCurrentLocation,
            child: Icon(Icons.my_location),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 70,
          right: 70,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RideBookingScreen(
                  startLocation: viewModel.addressController.text,
                  endLocation: viewModel.destinationController.text,
                ),
              ));
            },
            child: Text('Book Ride'),
          ),
        ),
      ],
    );
  }
}
