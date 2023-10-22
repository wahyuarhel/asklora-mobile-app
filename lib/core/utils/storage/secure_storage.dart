import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage.dart';

class SecureStorage implements Storage {
  static final SecureStorage _secureStorage = SecureStorage._internal();

  factory SecureStorage() {
    return _secureStorage;
  }

  SecureStorage._internal();

  final _flutterSecureStorage = const FlutterSecureStorage();

  @override
  Future<void> writeData(String key, String value) async =>
      await _flutterSecureStorage.write(
          key: key, value: value, aOptions: _getAndroidOptions());

  @override
  Future<String?> readData(String key) async => await _flutterSecureStorage
      .read(key: key, aOptions: _getAndroidOptions());

  @override
  Future<void> deleteData(String key) async =>
      _flutterSecureStorage.delete(key: key, aOptions: _getAndroidOptions());

  @override
  Future<void> deleteAllData() async =>
      await _flutterSecureStorage.deleteAll(aOptions: _getAndroidOptions());

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<int?> readIntData(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> writeIntData(String key, int value) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> readBoolData(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> writeBoolData(String key, bool value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> containsKey(String key) {
    throw UnimplementedError();
  }
}
