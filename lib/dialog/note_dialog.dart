import 'package:flutter/material.dart';
import '../models/note_model.dart';


class NoteDialog extends StatelessWidget {
  final Note note;

  const NoteDialog({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Center(
        child: Text(
          "Note Details",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _row("Row", note.row.toString()),
          _row("Status", note.status.name),
          _row("Pitch", note.pitch),
          _row("Accidental", note.accidental?.name ?? ""),
          _row("Hand", note.hand.name),
          _row("Finger", note.finger?.name ?? ""),
          _row("Articulation", note.articulation?.name ?? ""),
          _row("Created", note.createdAt.toString()),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Close",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$label: $value",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }
}