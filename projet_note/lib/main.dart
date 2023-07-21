import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_note/add_note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
                builder: (BuildContext) {
                  return const AddNote();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
      body: NoteInformation(),
    );
  }
}

class NoteInformation extends StatefulWidget {
  const NoteInformation({super.key});

  @override
  State<NoteInformation> createState() => _NoteInformationState();
}

class _NoteInformationState extends State<NoteInformation> {
  final Stream<QuerySnapshot> _noteStream =
      FirebaseFirestore.instance.collection('collection_note').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _noteStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> collection_note =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  for (final matiere in collection_note['matiere'])
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Chip(
                        label: Text(matiere),
                      ),
                    ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(collection_note['note']),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

//password : kRTza@LkdfDkz29 user : flutter db : tp_flutter
