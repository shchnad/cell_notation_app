class ContentFilterService {

  static const List<String> bannedWords = [
    'fuck',
    'bit',
    'asshole',
  ];

  static bool isValid(String text) {
    final lower = text.toLowerCase();

    return !bannedWords.any((word) => lower.contains(word));
  }
}