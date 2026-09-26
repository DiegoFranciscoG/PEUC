import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/domain/admission_rules.dart';

void main() {
  test('official structure: 5 components × 12 questions = 60 in 70 minutes', () {
    expect(AdmissionRules.areaOrder.length * AdmissionRules.questionsPerArea, AdmissionRules.totalQuestions);
    expect(AdmissionRules.examDuration, const Duration(minutes: 70));
    expect(AdmissionRules.wrongPoints, closeTo(-1 / 3, 1e-12));
    expect(AdmissionRules.examWeight + AdmissionRules.academicBackgroundWeight, 1);
  });

  test('every field weighs the five components and adds up to 100 %', () {
    for (final field in knowledgeFields) {
      expect(field.weights.keys.toSet(), AdmissionRules.areaOrder.toSet(), reason: field.name);
      expect(field.weights.values.fold(0, (a, b) => a + b), 100, reason: field.name);
    }
  });

  test('abstract reasoning weighs 20 % in every field', () {
    expect(knowledgeFields.every((f) => f.weights['RAB'] == 20), isTrue);
  });

  test('56 careers (53 de grado + 3 tecnológicas), each in exactly one field', () {
    final careers = [for (final f in knowledgeFields) ...f.careers];
    expect(careers.length, 56);
    expect(careers.toSet().length, careers.length);
    expect(fieldOfCareer('Medicina')!.code, 'CN');
    expect(fieldOfCareer('Computación')!.code, 'M');
    expect(fieldOfCareer('No existe'), isNull);
  });

  test('unknown field code falls back to the first field', () {
    expect(fieldByCode('???'), knowledgeFields.first);
  });
}
