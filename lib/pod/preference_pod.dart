import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final podPreferencesCredentials = NotifierProvider(
  () => SharedPreferencesListNotifier("credentials", []),
);

class SharedPreferencesNotifier<T> extends Notifier<T> {
  SharedPreferencesNotifier(this._key, this._initial);

  final String _key;
  final T _initial;

  late final SharedPreferencesWithCache _sp;

  @override
  T build() {
    _sp = ref.read(podSharedPreferences);
    switch (T) {
      case const (int):
        return _sp.getInt(_key) as T? ?? _initial;
      case const (double):
        return _sp.getDouble(_key) as T? ?? _initial;
      case const (bool):
        return _sp.getBool(_key) as T? ?? _initial;
      case const (String):
        return _sp.getString(_key) as T? ?? _initial;
      case const (List<String>):
        return _sp.getStringList(_key) as T? ?? _initial;
      default:
        throw UnimplementedError();
    }
  }

  Future<void> save(T value) async {
    switch (T) {
      case const (int):
        await _sp.setInt(_key, value as int);
      case const (double):
        await _sp.setDouble(_key, value as double);
      case const (bool):
        await _sp.setBool(_key, value as bool);
      case const (String):
        await _sp.setString(_key, value as String);
      case const (List<String>):
        await _sp.setStringList(_key, value as List<String>);
      default:
        throw UnimplementedError();
    }
    state = value;
  }
}

class SharedPreferencesListNotifier
    extends SharedPreferencesNotifier<List<String>> {
  SharedPreferencesListNotifier(super.key, super.initial);

  void add(String value) {
    save([...state, value]);
  }
}

final podSharedPreferences = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError(),
);
