import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../enums/status.dart';
import '../enums/hand.dart';
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
      widget.note.status =
      widget.note.status == Status.start
          ? Status.silence
          : Status.start;
    });
  }

  void _onLongPress() {
    setState(() {
      widget.note.status =
      widget.note.status == Status.hold
          ? Status.silence
          : Status.hold;
    });
  }

  void _onDoubleTap() {
    showDialog(
      context: context,
      builder: (_) => NoteDialog(note: widget.note),
    );
  }

  Color _backgroundColor() {
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
            : Colors.black);
    }
  }

  Color _textColor() {
    if (widget.note.status == Status.start) {
      return Colors.white;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      onDoubleTap: _onDoubleTap, //
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColor(),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(
              widget.note.pitch,
              style: TextStyle(
                fontSize: widget.size * 0.4,
                fontWeight: FontWeight.bold,
                color: _textColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}