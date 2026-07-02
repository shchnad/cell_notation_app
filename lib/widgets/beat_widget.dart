import 'package:flutter/material.dart';
import '../enums/hand.dart';
import '../models/beat_model.dart';
import 'note_widget.dart';

class BeatWidget extends StatelessWidget {
  final Beat beat;
  final double cellSize;
  final Hand currentHand;

  const BeatWidget({
    super.key,
    required this.beat,
    required this.cellSize,
    required this.currentHand,
  });

  @override
  Widget build(BuildContext context) {
    final totalRows = beat.notes.length;
    final numberOfOctaves = totalRows ~/ 7;

    // Between octave 2-3 (4 octaves) or 4-5 (8 octaves)
    final middleSeparator = (numberOfOctaves ~/ 2) * 7;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalRows, (row) {
        double topBorderWidth = 0.5;

        // Normal octave separator
        if (row > 0 && row % 7 == 0) {
          topBorderWidth = 1;
        }

        // Thick middle separator
        if (row == middleSeparator) {
          topBorderWidth = 2.5;
        }

        return NoteWidget(
          note: beat.notes[row],
          size: cellSize,
          currentHand: currentHand,
          topBorderWidth: topBorderWidth,
        );
      }),
    );
  }
}