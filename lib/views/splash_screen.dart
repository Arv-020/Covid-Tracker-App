import 'dart:async';

import 'package:covidtracker/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animation =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedBuilder(
            animation: _animation,
            child: const SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: Image(image: AssetImage('images/virus.png')),
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value * 2 * math.pi,
                child: child,
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          const Center(
            child: Text(
              'Covid-19\nTracker aPP',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.tealAccent, fontSize: 25),
            ),
          )
        ]),
      ),
    );
  }
}
