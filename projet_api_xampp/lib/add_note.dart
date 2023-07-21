import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect/multiselect.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projet_api_xampp/api_response.dart';
import 'package:projet_api_xampp/constant.dart';
import 'package:projet_api_xampp/liste_note.dart';

class Note {
  int id;
  String note;
  String matiere;
  Note({required this.id, required this.note, required this.matiere});
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      note: json['note'],
      matiere: json['matiere'],
    );
  }
}

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var formKey = GlobalKey<FormState>();
  var noteController = TextEditingController();
  List<String> matieres = [];

  Future<void> sauvegardeNote() async {
    final urlPost = Uri.parse('http://10.1.2.13:8000/store');
    final reponse = await http.post(
      urlPost,
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode({'note': noteController.text, 'matiere': matieres}),
    );

    if (reponse.statusCode == 200) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (contexte) => ListeNote()),
      );
    } else {
      Fluttertoast.showToast(msg: "Echec pour l'ajout");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Colors.white30, width: 1.5),
            ),
            title: Row(
              children: [
                const Text('Note : '),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: noteController,
                    validator: (value) => value == ""
                        ? "s'il vous plait saisie votre note"
                        : null,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DropDownMultiSelect(
            onChanged: (List<String> x) {
              setState(() {
                matieres = x;
              });
            },
            options: const ['JavaScript', 'Java', 'Php', 'Angular'],
            selectedValues: matieres,
            whenEmpty: 'Matiere',
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              //await sauvegardeNote();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext) {
                    return ListeNote();
                  },
                ),
              );
            },
            child: const Text('Soumettre'),
          ),
        ]),
      ),
    );
  }
}
