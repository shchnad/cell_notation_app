import 'note_model.dart';

class Beat {
  final String id;
  final double beatDuration;
  final int beatPerMeasure;
  final int index;
  final List<Note> notes;

  const Beat({
    required this.id,
    required this.index,
    required this.beatDuration,
    required this.beatPerMeasure,
    required this.notes,
  });
}