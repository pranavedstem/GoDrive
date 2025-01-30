import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Service'),centerTitle: true,),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TappableContainer(
                    label: 'Tap 1',
                    color: Colors.blue,
                    onTap: () {
                      
                    },
                  ),
                  TappableContainer(
                    label: 'Tap 2',
                    color: Colors.green,
                    onTap: () {
                      
                    },
                  ),
                ],
              ),
              SizedBox(height: 20), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButtonContainer(
                    icon: Icons.home,
                    color: Colors.orange,
                    onTap: () {
                      
                    },
                  ),
                  IconButtonContainer(
                    icon: Icons.search,
                    color: Colors.purple,
                    onTap: () {
                     
                    },
                  ),
                  IconButtonContainer(
                    icon: Icons.settings,
                    color: Colors.red,
                    onTap: () {
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class TappableContainer extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const TappableContainer({super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        color: color,
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class IconButtonContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const IconButtonContainer({super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: color,
          // shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}