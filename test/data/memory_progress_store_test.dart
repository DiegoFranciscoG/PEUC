import 'package:flutter_test/flutter_test.dart';
import 'package:peuc/data/progress_store.dart';

import 'progress_store_contract.dart';

void main() {
  test('the in-memory store is not persistent', () {
    expect(MemoryProgressStore().persistent, isFalse);
  });

  group('in-memory store contract', () {
    progressStoreContract(() async => MemoryProgressStore());
  });
}
