import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/provider/sign_in_provider.dart';
import 'package:teste/screens/home_screen.dart';
import 'package:teste/screens/login_screen.dart';
import 'package:teste/utils/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key?key}):super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    Timer(const Duration(seconds: 2),() {
        sp.isSignedIn == false
        ? Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (contexte) => const LoginScreen()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (contexte) => const HomeScreen()));
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage(Config.app_con),
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
