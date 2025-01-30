import 'dart:async';
import 'package:dummyprojecr/view/screens/signin.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    });
  }

 @override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            // child:
            //  Text('hii'),
            child: Image.asset(
              'assets/images/splash.png',
              width: screenWidth,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );
}

}
 class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          
          Image.asset(
            'assets/images/splash.png',
            height: screenHeight,
            width: screenWidth,
            fit: BoxFit.contain,
          ),
          
          Positioned(
            bottom: 50, 
            left: 0,
            right: 0,
            child: Center(widthFactor: 10,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ),
                  );
                },
                label: Text('Get Started',selectionColor: Colors.white,),
                icon: Icon(Icons.arrow_forward_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}