import 'package:dummyprojecr/view/screens/maps.dart';
import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find your Path'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    // elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Color.fromARGB(255, 117, 116, 116), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: const [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Current Location',
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.location_on),
                            ),
                          ),
                          // SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Where to?',
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Maps(),
              ),
            );
                  },
                  mini: true,
                  child: const Icon(Icons.add,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}