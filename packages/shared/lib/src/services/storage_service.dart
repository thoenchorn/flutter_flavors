/// Storage service interface for local data persistence
abstract class StorageService {
  /// Save string value with key
  Future<bool> setString(String key, String value);

  /// Get string value by key
  Future<String?> getString(String key);

  /// Save integer value with key
  Future<bool> setInt(String key, int value);

  /// Get integer value by key
  Future<int?> getInt(String key);

  /// Save boolean value with key
  Future<bool> setBool(String key, bool value);

  /// Get boolean value by key
  Future<bool?> getBool(String key);

  /// Save double value with key
  Future<bool> setDouble(String key, double value);

  /// Get double value by key
  Future<double?> getDouble(String key);

  /// Save list of strings with key
  Future<bool> setStringList(String key, List<String> value);

  /// Get list of strings by key
  Future<List<String>?> getStringList(String key);

  /// Remove value by key
  Future<bool> remove(String key);

  /// Clear all stored values
  Future<bool> clear();

  /// Check if key exists
  Future<bool> containsKey(String key);

  /// Get all keys
  Future<Set<String>> getKeys();
}

/// Mock storage service implementation for testing
class MockStorageService implements StorageService {
  final Map<String, dynamic> _storage = {};

  @override
  Future<bool> setBool(String key, bool value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool?> getBool(String key) async {
    return _storage[key] as bool?;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<double?> getDouble(String key) async {
    return _storage[key] as double?;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<int?> getInt(String key) async {
    return _storage[key] as int?;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<String?> getString(String key) async {
    return _storage[key] as String?;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _storage[key] as List<String>?;
  }

  @override
  Future<bool> remove(String key) async {
    _storage.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _storage.clear();
    return true;
  }

  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key);
  }

  @override
  Future<Set<String>> getKeys() async {
    return _storage.keys.toSet();
  }
}
