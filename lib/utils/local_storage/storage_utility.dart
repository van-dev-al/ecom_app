import 'package:get_storage/get_storage.dart';

class ELocalStorage {
  late final GetStorage _storage;

  static ELocalStorage? _instance;

  ELocalStorage._insternal();

  factory ELocalStorage.instance() {
    _instance ??= ELocalStorage._insternal();
    return _instance!;
  }

  static Future<void> init(String buketName) async {
    await GetStorage.init(buketName);
    _instance = ELocalStorage._insternal();
    _instance!._storage = GetStorage(buketName);
  }

  // Generic method to save data
  Future<void> saveData<E>(String key, E value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  E? readData<E>(String key) {
    return _storage.read<E>(key);
  }

  // Generic method to remove data
  Future<void> removeData<E>(String key) async {
    await _storage.remove(key);
  }

  // Method to clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
