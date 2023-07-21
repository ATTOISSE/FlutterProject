import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Note.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Stream<List<Note>> readNotes() => FirebaseFirestore.instance
      .collection('notes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((n) => Note.fromJson(n.data())).toList());
  Future<List<Note>> getStudent() async {
    String url = 'http://10.0.2.2:8000/note';
    String titre = 'Example Title';
    double contenu = 3.14159;
    final response = await http.get(Uri.parse(url));
    List<Note> list = List<Note>.from(
      jsonDecode(response.body).map(
        (item) => Note(
          matiere: item['matiere'],
          note: item['note'],
        ),
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            padding: EdgeInsets.all(15.0),
            /*child: StreamBuilder<List<Note>>(
                stream: readNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    return DataTable(
                      dataTextStyle: TextStyle(color: Colors.black),
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Matiere')),
                        DataColumn(label: Text('Note')),
                      ],
                      rows: List<DataRow>.generate(
                        notes.length,
                        (int index) {
                          final note = notes[index];
                          final color =
                              index.isOdd ? Colors.lightGreen : Colors.grey;

                          return DataRow(
                            cells: [
                              DataCell(
                                Text(index.toString()),
                              ),
                              DataCell(
                                Text(note.matiere.toString()),
                              ),
                              DataCell(
                                Text(note.note.toString()),
                              ),
                            ],
                            color: MaterialStateProperty.resolveWith<Color>(
                                (states) => color),
                          );
                        },
                      ),
                      border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        border: Border.all(color: Colors.grey),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Erreur: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                }),*/
            child: StreamBuilder<List<Note>>(
                stream: getStudent().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    return DataTable(
                      dataTextStyle: TextStyle(color: Colors.black),
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Matiere')),
                        DataColumn(label: Text('Note')),
                      ],
                      rows: List<DataRow>.generate(
                        notes.length,
                        (int index) {
                          final note = notes[index];
                          final color =
                              index.isOdd ? Colors.lightGreen : Colors.grey;

                          return DataRow(
                            cells: [
                              DataCell(
                                Text(index.toString()),
                              ),
                              DataCell(
                                Text(note.matiere.toString()),
                              ),
                              DataCell(
                                Text(note.note.toString()),
                              ),
                            ],
                            color: MaterialStateProperty.resolveWith<Color>(
                                (states) => color),
                          );
                        },
                      ),
                      border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellowAccent,
                        border: Border.all(color: Colors.grey),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Erreur: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
