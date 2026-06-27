class TonalityEngine {
  /// returns pitch for a given row
  static String getPitch({
    required int row,
    required List<String> scale,
  }) {
    if (scale.isEmpty) return "1";

    // 7-step repeating system
    final int index = row % 7;

    return scale[index];
  }

  /// optional helper: full 56-row pitch map
  static List<String> buildPitchMap({
    required List<String> scale,
    required int rows,
  }) {
    return List.generate(rows, (row) {
      return getPitch(row: row, scale: scale);
    });
  }
}