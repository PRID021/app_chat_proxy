abstract class DataStorage {
  init();
  Future<bool> write<T>(String key,T data);
  T read<T>(String key);
}
