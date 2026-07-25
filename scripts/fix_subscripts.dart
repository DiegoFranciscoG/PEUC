import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('assets/data/preguntas.json');
  var content = file.readAsStringSync(encoding: utf8);

  final replacements = {
    'â‚‚': '₂',
    'â‚†': '₆',
    'â‚₁â‚‚': '₁₂',
    'â‚₁': '₁',
    'â‚ƒ': '₃',
    'â‚„': '₄',
    'â†’': '→',
    'â€“': '–',
    'â€”': '—',
    'â€œ': '“',
    'â€': '”', // Some quotes might be this
    'â€\u009d': '”', 
    'â€˜': '‘',
    'â€™': '’',
    'â€¦': '…',
    'Â°': '°',
    'Ã‰': 'É',
    'Ã\u0089': 'É',
  };

  int total = 0;
  replacements.forEach((key, value) {
    int count = key.allMatches(content).length;
    if (count > 0) {
      print('Replacing \$count instances of "\$key" with "\$value"');
      total += count;
      content = content.replaceAll(key, value);
    }
  });

  print('Total fixes: \$total');
  
  if (total > 0) {
    try {
      final decoded = jsonDecode(content);
      file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(decoded), encoding: utf8);
      print('Success!');
    } catch (e) {
      file.writeAsStringSync(content, encoding: utf8);
      print('Saved as raw string because JSON parse failed: \$e');
    }
  }
}
