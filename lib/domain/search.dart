import 'models.dart';

const Map<String, String> _accents = {
  'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u', 'ü': 'u', 'ñ': 'n',
  'à': 'a', 'è': 'e', 'ì': 'i', 'ò': 'o', 'ù': 'u',
};

/// Lower case, without accents and with single spaces.
String normalizeForSearch(String input) {
  final buffer = StringBuffer();
  for (final rune in input.toLowerCase().runes) {
    final char = String.fromCharCode(rune);
    buffer.write(_accents[char] ?? char);
  }
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
}

/// Full-text search over stems and options of the bank.
class SearchIndex {
  SearchIndex(this.bank)
      : _texts = {
          for (final q in bank.questions)
            q.number: normalizeForSearch('${q.plainStem} ${q.options.map((o) => o.plainText).join(' ')}'),
        };

  final QuestionBank bank;
  final Map<int, String> _texts;

  /// A number returns that question; otherwise every word must appear.
  List<Question> search(String query, {String? areaCode}) {
    final pool = areaCode == null ? bank.questions : bank.byArea(areaCode);
    final normalized = normalizeForSearch(query);
    if (normalized.isEmpty) return pool;

    final number = int.tryParse(normalized);
    if (number != null) {
      final exact = bank.byNumber(number);
      return exact != null && (areaCode == null || exact.areaCode == areaCode) ? [exact] : [];
    }

    final words = normalized.split(' ');
    return pool.where((q) {
      final text = _texts[q.number]!;
      return words.every(text.contains);
    }).toList();
  }
}
