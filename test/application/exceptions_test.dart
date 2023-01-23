import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/application/exceptions.dart';

void main() {
  test('toString matches', () {
    expect('to string', const ApiKeyMissingException('to string').toString());
    expect('to string', const ImdbApiException('to string').toString());
  });
}