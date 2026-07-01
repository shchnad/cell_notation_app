import 'note_model.dart';

class Beat {
  final String id;
  final int measureId;
  final int index; // place in measure
  final int tempo;
  final String? musicalDynamic;
  final List<Note> notes;

  const Beat({
    required this.id,
    required this.measureId,
    required this.index,
    required this.tempo,
    this.musicalDynamic,
    required this.notes,
  });
}