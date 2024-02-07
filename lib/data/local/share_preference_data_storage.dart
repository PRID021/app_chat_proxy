import 'package:app_chat_proxy/data/local/data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareReferenceDataStorage extends DataStorage {
  static final ShareReferenceDataStorage _instance =
      ShareReferenceDataStorage._internal();
  ShareReferenceDataStorage._internal();

  // Obtain shared preferences.
  SharedPreferences? _prefs;

  @override
  T read<T>(String key) {
    if (_prefs == null) {
      throw "ShareReferenceDataStorage not initialize";
    }
    final prefs = (_prefs as SharedPreferences);
    try {
      final value = (prefs.get(key) as T);
      return value;
    } catch (e) {
      throw "Can't find value for $key with type ${T.runtimeType} with execption : $e";
    }
  }

  @override
  Future<bool> write<T>(String key, T data) async {
    if (_prefs == null) {
      throw "ShareReferenceDataStorage not initialize";
    }
    final prefs = (_prefs as SharedPreferences);
    if (T is int) {
      return await prefs.setInt(key, data as int);
    }
    if (T is bool) {
      return await prefs.setBool(key, data as bool);
    }
    if (T is double) {
      return await prefs.setDouble(key, data as double);
    }
    if (T is String) {
      return await prefs.setString(key, data as String);
    }
    if (T is List<String>) {
      return await prefs.setStringList(key, data as List<String>);
    }
    throw UnsupportedError("${T.runtimeType} is not supported");
  }

  @override
  Future init() async {
    _prefs = _instance._prefs ?? await SharedPreferences.getInstance();
  }
}
