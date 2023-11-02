import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future writeData(String key, String value) async {
    final writeValue = await _storage.write(key: key, value: value);
    return writeValue;
  }

  Future readData(String key) async {
    final readValue = await _storage.read(key: key);
    return readValue;
  }

  Future deleteData(String key) async {
    final deleteValue = await _storage.delete(key: key);
    return deleteValue;
  }
}
