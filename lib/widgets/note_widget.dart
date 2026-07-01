import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/status.dart';
import '../enums/hand.dart';

import '../models/note_model.dart';

import '../dialog/note_dialog.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final double size;

  const NoteWidget({
    super.key,
    required this.note,
    required this.size,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {

  void _onTap() {
    setState(() {
      if (widget.note.status == Status.start) {
        widget.note.status = Status.silence;
      } else {
        widget.note.status = Status.start;
      }
    });
  }

  void _onLongPress() {
    setState(() {
      if (widget.note.status == Status.hold) {
        widget.note.status = Status.silence;
      } else {
        widget.note.status = Status.hold;
      }
    });
  }

  void _onDoubleTap() {
    showDialog(
      context: context,
      builder: (_) => NoteDialog(note: widget.note),
    );
  }

  Color _color() {
    switch (widget.note.status) {
      case Status.silence:
        return Colors.white;

      case Status.start:
        return widget.note.hand == Hand.left
            ? Colors.blue
            : Colors.black;

      case Status.hold:
        return (widget.note.hand == Hand.left
            ? Colors.blue
            : Colors.black)
            .withOpacity(0.4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      onDoubleTap: _onDoubleTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _color(),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
    );
  }
}