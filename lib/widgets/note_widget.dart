import 'package:flutter/material.dart';
import '../dialog/note_dialog.dart';
import '../models/note_model.dart';
import '../enums/status.dart';
import '../enums/hand.dart';
import '../enums/articulation.dart';


class NoteWidget extends StatelessWidget {
  final Note note;
  final double size;

  const NoteWidget({
    super.key,
    required this.note,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (_) => NoteDialog(note: note),
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            color: _color(),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Color _color() {
    switch (note.status) {
      case Status.silence:
        return Colors.white;

      case Status.start:
        return note.hand == Hand.left ? Colors.blue : Colors.black;

      case Status.hold:
        return (note.hand == Hand.left ? Colors.blue : Colors.black)
            .withOpacity(0.4);
    }
  }
}