import 'dart:convert';

import '../shared_preference.dart';
import 'json_cache.dart';

class JsonCacheSharedPreferences implements JsonCache {
  final SharedPreference _sharedPreferences = SharedPreference();

  @override
  Future<void> clear() async {
    await _sharedPreferences.deleteAllData();
  }

  @override
  Future<void> remove(String key) async {
    await _sharedPreferences.deleteData(key);
  }

  ///
  /// **[Note]**
  /// In order to store the model in JSON string, please make sure the model has
  /// `toJson` method implementation.
  ///
  @override
  Future<void> refresh(String key, dynamic value) async {
    if (value is List) {
      final json = jsonEncode(value.map((e) => e.toJson()).toList());
      await _sharedPreferences.writeData(key, json);
    } else {
      await _sharedPreferences.writeData(key, jsonEncode(value.toJson()));
    }
  }

  @override
  dynamic value(String key) async {
    final strJson = await _sharedPreferences.readData(key);
    if (strJson == null) {
      return null;
    }
    return json.decode(strJson);
  }

  @override
  Future<bool> contains(String key) async {
    return _sharedPreferences.containsKey(key);
  }
}
