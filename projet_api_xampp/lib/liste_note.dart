import 'package:fluttertoast/fluttertoast.dart';

import 'add_note.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListeNote extends StatefulWidget {
  @override
  _ListeNoteState createState() => _ListeNoteState();
}

class _ListeNoteState extends State<ListeNote> {
  @override
  void initState() {
    super.initState();
     _note();
  }

  List<Note> _notes = [];
  
  Future<void> _note() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.0.2:8000/save'));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'reussite');
        List<dynamic> jsonList = json.decode(response.body);
              List<Note> notes = [];
              jsonList.forEach((jsonNote) {
                Note nte = Note.fromJson(jsonNote);
                notes.add(nte);
              });
              setState(() {
                _notes = notes;
              });
            } else {
              throw Exception('Failed');
     }
    } catch (e) {
       print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des notes'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            final table_note = _notes[index];
            return Container(
              margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(table_note.note),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(table_note.matiere),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
