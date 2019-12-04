import 'package:flutter/material.dart';

class Note {
  final String data;
  final Color color;

  Note(this.data, this.color);
}

class NotesModel {
  Future<List<Note>> get data async => List.generate(15, (i) => Note('note $i', Colors.green));
}

