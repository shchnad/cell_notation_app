import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../enums/status.dart';
import '../enums/hand.dart';
import '../dialog/note_dialog.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final double size;
  final Hand currentHand;

  const NoteWidget({
    super.key,
    required this.note,
    required this.size,
    required this.currentHand,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {

  void _onTap() {
    setState(() {
      // ONLY NEW NOTES GET HAND ASSIGNED
      if (widget.note.status == Status.silence) {
        widget.note.hand = widget.currentHand;
        widget.note.status = Status.start;
      } else if (widget.note.status == Status.start) {
        widget.note.status = Status.silence;
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

  Color _backgroundColor() {
    if (widget.note.status == Status.silence) {
      return Colors.white;
    }

    return widget.note.hand == Hand.left
        ? Colors.blue
        : Colors.black;
  }

  Color _textColor() {
    return widget.note.status == Status.start
        ? Colors.white
        : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      onDoubleTap: _onDoubleTap,
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