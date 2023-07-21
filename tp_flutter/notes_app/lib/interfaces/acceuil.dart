import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/interfaces/add_notes.dart';
import 'package:notes_app/interfaces/list_notes.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AcceuilPAgeState();
}

class _AcceuilPAgeState extends State<AccueilPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Groupe-ISI.png',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNoteForm()),
                  );
                },
                child: Text('Ajouter une note'),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  fixedSize: Size(150, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notes()),
                  );
                },
                child: Text('List des notes'),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  fixedSize: Size(150, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Quitter'),
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  fixedSize: Size(150, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
