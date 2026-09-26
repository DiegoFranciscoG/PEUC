import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../domain/models.dart';
import 'bank_parser.dart';

const String bankAssetPath = 'assets/bank/bank.json';
const String bankImagesPath = 'assets/bank/img';

/// Loads the bundled official bank. The app is offline-first: the bank ships
/// inside the app, so it works without connection after installation.
class BankLoader {
  BankLoader({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  Future<QuestionBank> load() async {
    final raw = await _bundle.loadString(bankAssetPath);
    return compute(parseBank, raw);
  }
}
