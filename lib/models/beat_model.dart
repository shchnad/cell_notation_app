import 'note_model.dart';

class Beat {
  final String id;
  final double beatDuration;
  final int measureId;
  final int index;
  final List<Note> notes;

  const Beat({
    required this.id,
    required this.index,
    required this.beatDuration,
    required this.measureId,
    required this.notes,
  });
}