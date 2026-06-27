import 'note.dart';

class Beat {
  final String id;
  final int index;
  final List<Note> notes;

  const Beat({
    required this.id,
    required this.index,
    required this.notes,
  });
}