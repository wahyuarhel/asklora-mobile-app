abstract class Storage {
  Future<void> writeData(String key, String value);

  Future<void> writeBoolData(String key, bool value);

  Future<void> writeIntData(String key, int value);

  Future<String?> readData(String key);

  Future<int?> readIntData(String key);

  Future<bool?> readBoolData(String key);

  Future<void> deleteData(String key);

  Future<void> deleteAllData();

  Future<bool> containsKey(String key);
}
