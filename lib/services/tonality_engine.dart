class TonalityEngine {

  static String getPitch({
    required int row,
    required List<String> scale,
  }) {
    if (scale.isEmpty) return "1";
    final int index = row % 7;
    return scale[index];
  }


  static List<String> buildPitchMap({
    required List<String> scale,
    required int rows,
  }) {
    return List.generate(rows, (row) {
      return getPitch(row: row, scale: scale);
    });
  }
}