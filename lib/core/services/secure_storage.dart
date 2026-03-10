import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movix/features/auth/data/models/user_model.dart';

class SecureStorage {
  final FlutterSecureStorage storage;

  const SecureStorage({this.storage = const FlutterSecureStorage()});

  // ─── Keys ───────────────────────────────────────
  static const String _requestTokenKey = 'request_token';
  static const String _sessionIdKey = 'session_id';
  static const String _userIdKey = 'user_id';
  static const String _userDataKey = 'user_data';

  // ─── Request Token ───────────────────────────────
  Future<String?> getUserRequestToken() => storage.read(key: _requestTokenKey);

  Future<void> setUserRequestToken(String token) =>
      storage.write(key: _requestTokenKey, value: token);

  // ─── Session ID ──────────────────────────────────
  Future<String?> getUserSessionId() => storage.read(key: _sessionIdKey);

  Future<void> setUserSessionId(String sessionId) =>
      storage.write(key: _sessionIdKey, value: sessionId);

  // ─── User ID ─────────────────────────────────────
  Future<String?> getUserId() => storage.read(key: _userIdKey);

  Future<void> setUserId(String userId) =>
      storage.write(key: _userIdKey, value: userId);

  // ─── User Data ───────────────────────────────────
  Future<void> writeUserData({required UserModel userModel}) async {
    await storage.write(
      key: _userDataKey,
      value: jsonEncode(userModel.toJson()),
    );
    await setUserId(userModel.id.toString());
  }

  Future<Map<String, dynamic>?> readUserData() async {
    final value = await storage.read(key: _userDataKey);
    if (value != null) return jsonDecode(value);
    return null;
  }

  Future<String> getUserImageUrl() async {
    final data = await readUserData();
    if (data == null) return "";
    final usermodel = UserModel.fromJson(data);
    return usermodel.avatarPath!;
  }

  Future<void> setUserRatingMovie(int movieId, double rateValue) async =>
     await storage.write(key: 'movie_rating_$movieId', value: rateValue.toString());

  Future<String?> getUserRatingMovie(int movieId) async {
    return storage.read(key: 'movie_rating_$movieId');
  }

  Future<void> deleteUserRatingMovie(int movieId) async {
    await storage.delete(key: 'movie_rating_$movieId');
  }

  Future<void> setUserRatingTVSeries(int tvSeriesId, double rateValue) async =>
     await storage.write(key: 'tvSeries_rating_$tvSeriesId', value: rateValue.toString());

  Future<String?> getUserRatingTVSeries(int tvSeriesId) async {
    return storage.read(key: 'tvSeries_rating_$tvSeriesId');
  }

  Future<void> deleteUserRatingTVSeries(int tvSeriesId) async {
    await storage.delete(key: 'tvSeries_rating_$tvSeriesId');
  }

  Future<void> deleteUserData() async {
    await storage.delete(key: _userDataKey);
  }

  // ─── Clear Auth (on logout) ───────────────────────
  Future<void> clearTokens() async {
    await storage.delete(key: _sessionIdKey);
    await storage.delete(key: _requestTokenKey);
    await storage.delete(key: _userIdKey);
    await storage.delete(key: _userDataKey);
  }

  // ─── Nuclear option ──────────────────────────────
  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }
}
