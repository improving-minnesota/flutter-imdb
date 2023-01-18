import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/data/models/key_value.dart';

void main() {
  group('test fromJson', () {
    test('happy path', () {
      KeyValue kv = KeyValue.fromJson({'key': 'a', 'value': 'b'});

      expect(kv.key, 'a');
      expect(kv.value, 'b');
    });

    test('null key', () {
      expect(() => KeyValue.fromJson({'value': 'b'}), throwsA(isA<TypeError>()));
    });

    test('null value', () {
      expect(() => KeyValue.fromJson({'key': 'a'}), throwsA(isA<TypeError>()));
    });

  });
}