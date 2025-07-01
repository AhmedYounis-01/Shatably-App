import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageManager {
  StorageManager._();
  static final StorageManager instance = StorageManager._();
  late SharedPreferences _sharedPreferences;

  /// Initialize SharedPreferences instance
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save a value (String, bool, int, or double) into SharedPreferences
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);

    throw UnsupportedError('Unsupported type for SharedPreferences');
  }

  /// Retrieve a value from SharedPreferences
  T? getData<T>({required String key}) {
    return _sharedPreferences.get(key) as T?;
  }

  /// Remove a value by key from SharedPreferences
  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  /// Check if a key exists in SharedPreferences
  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  Future<bool> hasSeenOnboarding() async {
    final bool hasSeen = getData<bool>(key: "hasSeenOnboarding") ?? false;
    return hasSeen;
  }

  setHasSeenOnboarding() {
    saveData(key: 'hasSeenOnboarding', value: true);
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  setSecuredString({required String key, required String value}) async {
    const flutterSecureStorage = FlutterSecureStorage();

    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  getSecuredString({required String key}) async {
    const flutterSecureStorage = FlutterSecureStorage();

    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes a specific key from FlutterSecureStorage
  removeSecuredString({required String key}) async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  clearAllSecuredData() async {
    // PrintDebugConsole.i('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
