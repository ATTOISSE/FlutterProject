import 'package:flutter/material.dart';
import 'package:projet_api_xampp/add_note.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), 
      title: 'Gestion des Note',
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des notes'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                // ignore: avoid_types_as_parameter_names
                builder: (BuildContext) {
                  return const AddNote();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

//password : kRTza@LkdfDkz29 user : flutter db : tp_flutter
