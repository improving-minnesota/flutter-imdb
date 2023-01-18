import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/data/datasources/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  group('storage service tests', () {
    test('getApiKey', () async {
      final mockStorage = MockFlutterSecureStorage();
      final container = ProviderContainer(overrides: [
        flutterSecureStorageProvider.overrideWithValue(mockStorage),
      ]);

      when(mockStorage.read(key: StorageService.apiKey)).thenAnswer(
        (realInvocation) async {
          return 'aaa111';
        },
      );

      String apiKey = (await container.read(storageServiceProvider).getApiKey())!;

      expect(apiKey, 'aaa111');
    });
  });

  group('storage service tests', () {
    test('setApiKey', () async {
      final mockStorage = MockFlutterSecureStorage();
      final container = ProviderContainer(overrides: [
        flutterSecureStorageProvider.overrideWithValue(mockStorage),
      ]);

      (await container.read(storageServiceProvider).setApiKey('aaa222'));

      verify(mockStorage.write(key: StorageService.apiKey, value: 'aaa222')).called(1);
    });
  });
}
