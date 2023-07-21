class Note {
  final String? matiere;
  final double? note;

  Note({
    required this.matiere,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
        'matiere': matiere,
        'note': note,
      };

  static Note fromJson(Map<String, dynamic> json) => Note(
        matiere: json['matiere'],
        note: json['note'].toDouble(),
      );
}
