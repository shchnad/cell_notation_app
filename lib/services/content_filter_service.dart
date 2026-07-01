class ContentFilterService {
  static const List<String> bannedWords = [
    'fuck',
    'asshole',
  ];

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  static bool isValid(String text) {
    final clean = _normalize(text);
    return !bannedWords.any((w) => clean.contains(_normalize(w)));
  }
}