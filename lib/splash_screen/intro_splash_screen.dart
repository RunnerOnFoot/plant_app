import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/splash_screen.dart';

class IntroSplashScreen extends StatefulWidget {
  const IntroSplashScreen({super.key});

  @override
  State<IntroSplashScreen> createState() => _IntroSplashScreenState();
}

class _IntroSplashScreenState extends State<IntroSplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 2500,
        ), () {
      Navigator.push(
        context,
        PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.fade,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/images/plant_icon.png'),
          ),
        ),
      ),
    );
  }
}
