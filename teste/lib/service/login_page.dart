import 'package:flutter/material.dart';
import 'package:teste/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Google Login'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: size.height * 0.2,
            bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("HellO!!! Goodle Sign In",
                style: TextStyle(fontSize: 30)),
            GestureDetector(
              onTap: () {
                AuthService().signInWithGoogle();
              },
              child: const Image(width: 100,image: AssetImage('assets/images/google.png'),),
            )
          ],
        ),
      ),
    );
  }
}
