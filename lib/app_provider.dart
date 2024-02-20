import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saved/constants/values.dart';
import 'package:saved/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppProvider extends ChangeNotifier {
  var _locale = Locale(env.defaultAppLanguageCode);
  var _themeMode = ThemeMode.system;
  var _userProfileImageUrl = '';
  var _id = '';
  var _fullName = '';
  var _role = '';
  var _accessToken = '';
  var _current = '';
  List<String> _previous = <String>[];
  var _companyId = '';
  var _companyName = '';

  String get userProfileImageUrl => _userProfileImageUrl;
  String get id => _id;
  String get fullName => _fullName;
  String get role => _role;
  String get accessToken => _accessToken;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  String get current => _current;
  List<String> get previouses => _previous;
  String get previous => _previous.last;
  String get companyId => _companyId;
  String get companyName => _companyName;
  bool get isLogin => _id.isNotEmpty ? true : false;
  bool get isAdmin => _role == 'admin' ? true : false;

  Future<void> loadAsync() async {
    final sharedPref = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();

    final langCode = (sharedPref.getString(StorageKeys.appLanguageCode) ??
        env.defaultAppLanguageCode);

    if (langCode.contains('_')) {
      final values = langCode.split('_');

      _locale =
          Locale.fromSubtags(languageCode: values[0], scriptCode: values[1]);
    } else {
      _locale = Locale(langCode);
    }

    _themeMode = ThemeMode.values.byName(
        sharedPref.getString(StorageKeys.appThemeMode) ??
            ThemeMode.system.name);

    _id = sharedPref.getString(StorageKeys.id) ?? '';
    _fullName = sharedPref.getString(StorageKeys.fullName) ?? '';
    _role = sharedPref.getString(StorageKeys.role) ?? '';
    _userProfileImageUrl =
        sharedPref.getString(StorageKeys.userProfileImageUrl) ?? '';
    _current = sharedPref.getString(StorageKeys.current) ?? '';

    try {
      final pre = sharedPref.getString(StorageKeys.previous);
      if (pre != null) {
        _previous = pre.split(',');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    _companyId = sharedPref.getString(StorageKeys.companyId) ?? '';
    _companyName = sharedPref.getString(StorageKeys.companyName) ?? '';

    _accessToken = await storage.read(key: StorageKeys.accessToken) ?? '';

    notifyListeners();
  }

  Future<void> setLocaleAsync({
    required Locale locale,
    save = true,
  }) async {
    if (locale != _locale) {
      _locale = locale;

      if (save) {
        final sharedPref = await SharedPreferences.getInstance();
        var langCode = locale.languageCode;

        if (locale.scriptCode != null) {
          langCode += '_${locale.scriptCode}';
        }

        await sharedPref.setString(StorageKeys.appLanguageCode, langCode);
      }

      notifyListeners();
    }
  }

  Future<void> setThemeModeAsync({
    required ThemeMode themeMode,
    bool save = true,
  }) async {
    if (themeMode != _themeMode) {
      _themeMode = themeMode;

      if (save) {
        final sharedPref = await SharedPreferences.getInstance();

        await sharedPref.setString(StorageKeys.appThemeMode, themeMode.name);
      }

      notifyListeners();
    }
  }

  Future<void> setAccessToken(String? accessToken) async {
    const storage = FlutterSecureStorage();

    if (accessToken != null && accessToken != _accessToken) {
      _accessToken = accessToken;

      await storage.write(key: StorageKeys.accessToken, value: accessToken);

      notifyListeners();
    }
  }

  Future<void> setUserDataAsync({
    String? userProfileImageUrl,
    String? id,
    String? fullName,
    String? role,
  }) async {
    final sharedPref = await SharedPreferences.getInstance();
    var shouldNotify = false;

    if (userProfileImageUrl != null &&
        userProfileImageUrl != _userProfileImageUrl) {
      _userProfileImageUrl = userProfileImageUrl;

      await sharedPref.setString(
          StorageKeys.userProfileImageUrl, _userProfileImageUrl);

      shouldNotify = true;
    }

    if (id != null && id != _id) {
      _id = id;

      await sharedPref.setString(StorageKeys.id, _id);

      shouldNotify = true;
    }

    if (fullName != null && fullName != _fullName) {
      _fullName = fullName;

      await sharedPref.setString(StorageKeys.fullName, _fullName);

      shouldNotify = true;
    }

    if (role != null && role != _role) {
      _role = role;

      await sharedPref.setString(StorageKeys.role, _role);

      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  Future<void> clearDataAsync() async {
    final sharedPref = await SharedPreferences.getInstance();

    await sharedPref.clear();

    _companyId = '';
    _companyName = '';

    notifyListeners();
  }

  bool isUserLoggedIn() {
    return _id.isNotEmpty;
  }

  Future<void> setPrevious(String previous) async {
    final sharedPref = await SharedPreferences.getInstance();
    bool existedPre = _previous.any((pre) => pre == previous);
    bool existedCur = _previous.any((pre) => pre == current);
    if (existedPre) {
      _previous.removeWhere((pre) => pre == previous);
    } else if (existedCur) {
      _previous.removeWhere((pre) => pre == current);
    } else {
      _previous.add(previous);
    }

    await sharedPref.setString(StorageKeys.previous, _previous.join(','));

    notifyListeners();
  }

  Future<void> clearPrevious() async {
    final sharedPref = await SharedPreferences.getInstance();

    await sharedPref.remove(StorageKeys.previous);

    _previous = [];

    notifyListeners();
  }

  Future<void> clearCurrent() async {
    final sharedPref = await SharedPreferences.getInstance();

    await sharedPref.remove(StorageKeys.current);

    _current = "";

    notifyListeners();
  }

  Future<void> setCurrent(String current) async {
    final sharedPref = await SharedPreferences.getInstance();
    if (current != _current) {
      _current = current;

      await sharedPref.setString(StorageKeys.current, current);
    }

    notifyListeners();
  }

  Future<void> setCompanyAsync({
    required String companyId,
    String? companyName,
    bool shouldNotify = false,
  }) async {
    final sharedPref = await SharedPreferences.getInstance();
    if (companyId != _companyId) {
      _companyId = companyId;

      await sharedPref.setString(StorageKeys.companyId, companyId);

      shouldNotify = true;
    }

    if (companyName != _companyName) {
      _companyName = companyName!;

      await sharedPref.setString(StorageKeys.companyName, companyName);

      shouldNotify = true;
    }
    if (shouldNotify) {
      notifyListeners();
    }
  }
}
