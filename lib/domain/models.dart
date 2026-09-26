import 'package:flutter/foundation.dart';

/// A piece of a stem or option: either a text paragraph or a picture taken
/// from the official PDF (rendered inline, in the original order).
@immutable
class ContentBlock {
  const ContentBlock.text(String this.text)
      : image = null,
        width = null,
        height = null;
  const ContentBlock.image(String this.image, {this.width, this.height}) : text = null;

  final String? text;
  final String? image;

  /// Size (PDF points) of the picture in the official document, when known.
  final double? width;
  final double? height;

  bool get isImage => image != null;
}

@immutable
class AnswerOption {
  const AnswerOption({required this.label, required this.blocks});

  /// Letter used in the official bank (a, b, c...).
  final String label;
  final List<ContentBlock> blocks;

  String get plainText => blocks.where((b) => !b.isImage).map((b) => b.text).join(' ');

  bool get hasImage => blocks.any((b) => b.isImage);
}

/// How the resolved answer was cross-checked against the official options.
enum AnswerCheck {
  /// The answer text matches the official option with that letter.
  text,

  /// The answer picture matches the official option with that letter.
  image,

  /// Not comparable automatically; verified by hand.
  manual,

  /// Letter and content disagree (none remain in the published bank).
  conflict;

  static AnswerCheck parse(String value) =>
      AnswerCheck.values.firstWhere((c) => c.name == value, orElse: () => AnswerCheck.manual);
}

@immutable
class Question {
  const Question({
    required this.number,
    required this.page,
    required this.topicCode,
    required this.areaCode,
    required this.stem,
    required this.options,
    required this.answer,
    required this.justification,
    required this.check,
    this.note,
    this.flag,
  });

  /// Number in the official bank (1..2737).
  final int number;

  /// Page of the official PDF where the question starts.
  final int page;
  final String topicCode;
  final String areaCode;
  final List<ContentBlock> stem;
  final List<AnswerOption> options;

  /// Label of the correct option.
  final String answer;
  final String justification;
  final AnswerCheck check;

  /// Verification note shown to the student (imprecise item, correction...).
  final String? note;

  /// corregida | sin_opcion_correcta | ambigua
  final String? flag;

  bool get hasObservation => note != null;

  bool get wasCorrected => flag == 'corregida';

  bool isCorrect(String label) => label == answer;

  AnswerOption get correctOption => options.firstWhere((o) => o.label == answer);

  String get plainStem => stem.where((b) => !b.isImage).map((b) => b.text).join(' ');

  bool get hasImages => stem.any((b) => b.isImage) || options.any((o) => o.hasImage);
}

@immutable
class Area {
  const Area({required this.code, required this.prefix, required this.name});

  final String code;
  final String prefix;
  final String name;
}

@immutable
class Topic {
  const Topic({
    required this.code,
    required this.areaCode,
    required this.unitCode,
    required this.unit,
    required this.title,
  });

  final String code;
  final String areaCode;
  final String unitCode;
  final String unit;
  final String title;
}

/// The official question bank, indexed for the queries the app needs.
class QuestionBank {
  QuestionBank({
    required this.version,
    required this.sourceName,
    required this.sourceUrl,
    required this.sourceSha256,
    required this.areas,
    required this.topics,
    required this.questions,
  })  : _byNumber = {for (final q in questions) q.number: q},
        _areas = {for (final a in areas) a.code: a},
        _topics = {for (final t in topics) t.code: t};

  final String version;
  final String sourceName;
  final String sourceUrl;
  final String sourceSha256;
  final List<Area> areas;
  final List<Topic> topics;
  final List<Question> questions;

  final Map<int, Question> _byNumber;
  final Map<String, Area> _areas;
  final Map<String, Topic> _topics;

  Question? byNumber(int number) => _byNumber[number];

  Area area(String code) => _areas[code]!;

  Topic topic(String code) => _topics[code]!;

  List<Question> byArea(String areaCode) => questions.where((q) => q.areaCode == areaCode).toList();

  List<Question> byTopic(String topicCode) => questions.where((q) => q.topicCode == topicCode).toList();

  List<Topic> topicsOf(String areaCode) => topics.where((t) => t.areaCode == areaCode).toList();

  List<Question> get withObservation => questions.where((q) => q.hasObservation).toList();
}
