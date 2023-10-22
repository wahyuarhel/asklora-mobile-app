import 'package:shared_preferences/shared_preferences.dart';

import 'storage.dart';

class SharedPreference implements Storage {
  static final SharedPreference _sharedPreference =
      SharedPreference._internal();

  factory SharedPreference() {
    return _sharedPreference;
  }

  SharedPreference._internal();

  Future<SharedPreferences> _getPreference() async =>
      await SharedPreferences.getInstance();

  @override
  Future<void> deleteAllData() async =>
      await _getPreference().then((v) => v.clear());

  @override
  Future<void> deleteData(String key) async =>
      await _getPreference().then((v) => v.remove(key));

  @override
  Future<String?> readData(String key) async =>
      await _getPreference().then((v) => v.getString(key));

  @override
  Future<bool?> readBoolData(String key) async =>
      await _getPreference().then((v) => v.getBool(key));

  @override
  Future<bool> writeData(String key, String value) async =>
      await _getPreference().then((v) => v.setString(key, value));

  @override
  Future<bool> writeBoolData(String key, bool value) async =>
      await _getPreference().then((v) => v.setBool(key, value));

  @override
  Future<bool> writeIntData(String key, int value) async =>
      await _getPreference().then((v) => v.setInt(key, value));

  @override
  Future<int?> readIntData(String key) async =>
      await _getPreference().then((v) => v.getInt(key));

  @override
  Future<bool> containsKey(String key) async =>
      await _getPreference().then((value) => value.containsKey(key));

  Future<void> deleteAllDataExcept(List<String> keys) async {
    SharedPreferences sharedPreferences = await _getPreference();
    for (String key in sharedPreferences.getKeys()) {
      if (!keys.contains(key)) {
        sharedPreferences.remove(key);
      }
    }
  }
}
