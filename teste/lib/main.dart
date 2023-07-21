import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/provider/internet_provider.dart';
import 'package:teste/provider/sign_in_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:teste/provider/sign_in_provider.dart';
import 'package:teste/screens/login_screen.dart';
// import 'package:teste/screens/splash_screen.dart';
// import 'package:teste/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context)=>SignInProvider()),
          ),
        ChangeNotifierProvider(
          create: ((context)=>InternetProvider()),
          ),
    ],
    child: const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       themeMode: ThemeMode.system,
//         home: LoginScreen(),
//         debugShowCheckedModeBanner: false,
//     );
//   }
// }
