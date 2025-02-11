import 'package:dummyprojecr/models/signupmodel.dart';
import 'package:dummyprojecr/view/screens/home_screen.dart';
import 'package:dummyprojecr/view/screens/profile.dart';
import 'package:dummyprojecr/view/screens/service_screen.dart';

import 'package:dummyprojecr/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    final List<Widget> widgetOptions = <Widget>[
      Home(
        viewModel: homeViewModel,
        address: '',
      ),
      const ServiceScreen(),
      ProfilePage(user: widget.user),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dataset_rounded),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(198, 46, 66, 247),
        onTap: _onItemTapped,
      ),
    );
  }
}
