import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  StorageService({required this.secureStorage});

  static const apiKey = 'API_KEY';
  final log = Logger('StorageService');
  final FlutterSecureStorage secureStorage;

  Future<void> setApiKey(String key) async {
    return secureStorage.write(key: apiKey, value: key);
  }

  Future<String?> getApiKey() async {
    return secureStorage.read(key: apiKey);
  }

  void dispose() => {
  };
}

final storageServiceProvider = Provider.autoDispose<StorageService>((ref) {
  final storageService = StorageService(secureStorage: ref.watch(flutterSecureStorageProvider));
  ref.onDispose(() => storageService.dispose());
  return storageService;
});

final flutterSecureStorageProvider = Provider.autoDispose<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});