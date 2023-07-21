import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final noteController = TextEditingController();
  List<String> matieres = [];
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
                Text('Note : '),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    controller: noteController,
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
            options: const [
              'JavaScript', 
              'Java', 
              'Php', 
              'Angular',
              'Flutter',
              'Symfony'
              ],
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
              FirebaseFirestore.instance.collection('collection_note').add({
                'note': noteController.value.text,
                'matiere': matieres,
              });
              Navigator.pop(context);
            },
            child: const Text('Soumettre'),
          ),
        ]),
      ),
    );
  }
}
