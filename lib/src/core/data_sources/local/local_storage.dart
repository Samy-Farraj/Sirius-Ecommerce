import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/features/auth/domain/entities/app_user.dart';

class LocalStorage {
  static const String _tokenKey = 'token';
  static const String _fcmTokenKey = 'fcmToken';
  static const String _uuid = '_uuid';
  static const String _active = '_active';
  static const String _appUserKey = 'appUser';
  static const String _onBoardingCountKey = 'onBoardingCount';
  static const String _onBoardingSeenKey = 'onBoardingSeen';
  static const String _languageKey = 'language';
  static const String _rememberMe = 'rememberMe';
  static const String _anonymousUserId = 'anonymousUserId';

  final SharedPreferences _sharedPreferences;

  LocalStorage(this._sharedPreferences);

  bool get isUserAnonymous => appUser == null;

  String getUserId() {
    if (appUser != null) {
      return appUser!.id!.toString();
    }
    final String anonymousUserId = generateAnonymousUserId();
    return anonymousUserId;
  }

  String generateAnonymousUserId() {
    if (_getAnonymousUserId != null) {
      return _getAnonymousUserId!;
    }
    final anonymousUserId = const Uuid().v4();
    _sharedPreferences.setString(_anonymousUserId, anonymousUserId);
    return anonymousUserId;
  }

  String? get _getAnonymousUserId =>
      _sharedPreferences.getString(_anonymousUserId);

  Future<bool> storeToken(String token) async {
    return _sharedPreferences.setString(_tokenKey, token);
  }

  Future<bool> storeFcmToken(String fcmToken) async {
    print("THE FCM ${fcmToken}");
    return _sharedPreferences.setString(_fcmTokenKey, fcmToken);
  }

  Future<bool> storeUUID(String uuId) async {
    return _sharedPreferences.setString(_uuid, uuId);
  }

  Future<bool> storeIsActive(bool active) async {
    return _sharedPreferences.setBool(_active, active);
  }

  String? get token => _sharedPreferences.getString(_tokenKey);
  String? get fcmToken => _sharedPreferences.getString(_fcmTokenKey);
  String? get uuid => _sharedPreferences.getString(_uuid);
  bool? get active => _sharedPreferences.getBool(_active);
  Future<bool> clearToken() async => _sharedPreferences.remove(_tokenKey);

  Future<bool> storeOnBoardingCount() async {
    final int onBoarding;
    final seenCount = onBoardingSeenCount;
    final bool isOnBoardingSeen = onBoardingSeen;

    if (isOnBoardingSeen) {
      return true;
    }
    if (seenCount != null && seenCount >= 10) {
      return storeOnBoardingSeen();
    }
    if (seenCount == null) {
      onBoarding = 0;
    } else {
      onBoarding = onBoardingSeenCount! + 1;
    }

    return _sharedPreferences.setInt(_onBoardingCountKey, onBoarding);
  }

  int? get onBoardingSeenCount =>
      _sharedPreferences.getInt(_onBoardingCountKey);

  Future<bool> storeOnBoardingSeen() async =>
      _sharedPreferences.setBool(_onBoardingSeenKey, true);

  bool get onBoardingSeen =>
      _sharedPreferences.getBool(_onBoardingSeenKey) == true;

  Future<bool> clearOnBoarding() async =>
      _sharedPreferences.remove(_onBoardingSeenKey);

  Future<bool> storeLanguage(String lang) async =>
      await _sharedPreferences.setString(_languageKey, lang);

  String? get language => _sharedPreferences.getString(_languageKey);

  Future<bool> clearLanguage() async => _sharedPreferences.remove(_languageKey);

  Future<bool> clearPreviousAnonymousUserId() =>
      _sharedPreferences.remove(_anonymousUserId);

  Future<bool> storeAppUser(AppUser appUser) {
    clearPreviousAnonymousUserId();
    final appUserAsString = json.encode(appUser.toJson());
    return _sharedPreferences.setString(_appUserKey, appUserAsString);
  }

  AppUser? get appUser {
    final appUserAsString = _sharedPreferences.getString(_appUserKey);
    if (appUserAsString != null) {
      final appUser = AppUser.fromJson(json.decode(appUserAsString));
      return appUser;
    }
    return null;
  }

  Future<bool> clearAppUser() async => _sharedPreferences.remove(_appUserKey);

  Future<bool> storeRememberMe(bool rememberMe) async {
    return _sharedPreferences.setBool(_rememberMe, rememberMe);
  }

  bool? get rememberMe => _sharedPreferences.getBool(_rememberMe);

  Future<bool> clearRememberMe() async =>
      _sharedPreferences.remove(_rememberMe);

  Future clearOnLogout() {
    return Future.wait([
      clearAppUser(),
      clearToken(),
      clearRememberMe(),
    ]);
  }
}
