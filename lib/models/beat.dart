import '../models/note.dart';

class Beat {
  final String id;        // REQUIRED UNIQUE ID
  final int index;        // position in grid
  final int measureIndex; // for visual grouping

  final List<Note> cells; // ALWAYS 56 rows

  const Beat({
    required this.id,
    required this.index,
    required this.measureIndex,
    required this.cells,
  });
}