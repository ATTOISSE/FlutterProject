import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Note.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  List<DropdownMenuItem<String>> _matieres =
      ["PHP", "Flutter", "CSharp", "JAVA"]
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(option),
            ),
          )
          .toList();
  // donnee d'une note
  String? _matiere;
  double? _note = null;
  TextEditingController _controller = TextEditingController();
  double _minValue = 0.0;
  double _maxValue = 20.0;

  @override
  Widget build(BuildContext context) {
    Future<void> addNote() async {
      final note = Note(matiere: _matiere, note: _note);

      final notes = FirebaseFirestore.instance.collection('notes').doc();
      final json = note.toJson();
      this._matiere = null;
      this._note = null;

      await notes.set(json);
    }

    Future<void> store() async {
      String url = 'http://10.0.2.2:8000/note';
      String titre = 'Example Title';
      double contenu = 3.14159;

      Map<String, dynamic> data = {
        'matiere': _matiere,
        'note': _note,
      };

      // Convert the data to JSON
      String jsonData = jsonEncode(data);

      // Set the headers
      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      // Send the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonData,
      );

      print(response);

      // Check the response status code
      if (response.statusCode == 200) {
        print('Data sent successfully.');
      } else {
        print('Error sending data. Status code: ${response.statusCode}');
      }
    }

    Future<List<Note>> getStudent() async {
      String url = 'http://10.0.2.2:8000';
      Uri uri = Uri.http(url, '/note');
      String titre = 'Example Title';
      double contenu = 3.14159;
      final response = await http.get(uri);
      List<Note> list = jsonDecode(response.body).cast<Map<Note, dynamic>>();
      return list;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Matière",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: null,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                      ),
                      items: _matieres,
                      hint: Text("Veuillez choisir une matiere"),
                      iconSize: 0,
                      onChanged: (newValue) {
                        setState(() {
                          _matiere = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Note",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: null,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
                      onChanged: (value) {
                        if (_controller.text == "") {
                          _controller.value = TextEditingValue(
                            text: value,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: value.length),
                            ),
                          );
                        }
                        try {
                          if (double.parse(_controller.text) < _minValue) {
                            _controller.value = TextEditingValue(
                              text: "0.0",
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: "0.0".length),
                              ),
                            );
                          } else if (double.parse(_controller.text) >
                              _maxValue) {
                            _controller.value = TextEditingValue(
                              text: "20.0",
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: "20.0".length),
                              ),
                            );
                          }
                        } catch (e) {}
                      },
                      onTapOutside: (v) {
                        setState(() {
                          try {
                            _note = double.parse(_controller.text);
                          } catch (e) {}
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: (_matiere == null ||
                            _matiere.toString() == '' ||
                            _note == null)
                        ? null
                        : () {
                            // addNote();
                            store();
                            setState(() {
                              _matiere = null;
                              _note = null;
                            });
                            Navigator.pop(context);
                          },
                    child: Text('Ajouter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      // fixedSize: Size(0, 40),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
