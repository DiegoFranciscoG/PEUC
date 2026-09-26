import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/domain/search.dart';

import '../support/fixtures.dart';

void main() {
  test('normalizes accents, case and spaces', () {
    expect(normalizeForSearch('  Ecuación   CUADRÁTICA  '), 'ecuacion cuadratica');
    expect(normalizeForSearch('Pingüino y ñandú'), 'pinguino y nandu');
  });

  final index = SearchIndex(testBank());

  test('a number finds that question', () {
    expect(index.search('21').single.number, 21);
    expect(index.search('9999'), isEmpty);
  });

  test('all words must appear, ignoring accents', () {
    final results = index.search('ecuacion cuadratica');
    expect(results.single.number, 1);
    expect(index.search('ecuación inexistente'), isEmpty);
  });

  test('filters by area', () {
    expect(index.search('', areaCode: 'LEN').length, 20);
    expect(index.search('21', areaCode: 'MAT'), isEmpty);
  });

  test('an empty query returns everything', () {
    expect(index.search('   ').length, 100);
  });
}
