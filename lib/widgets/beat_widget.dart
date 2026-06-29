import 'package:flutter/material.dart';
import '../models/beat_model.dart';
import 'note_widget.dart';


class BeatWidget extends StatelessWidget {
  final Beat beat;
  final double cellSize;

  const BeatWidget({
    super.key,
    required this.beat,
    required this.cellSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: beat.notes.map((note) {
        return NoteWidget(
          note: note,
          size: cellSize,
        );
      }).toList(),
    );
  }
}