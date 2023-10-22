abstract class JsonCache {
  Future<void> clear();

  Future<void> remove(String key);

  dynamic value(String key);

  Future<void> refresh(String key, Map<String, dynamic> value);

  Future<bool> contains(String key);
}
