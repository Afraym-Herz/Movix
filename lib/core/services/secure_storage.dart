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
  static const String _userImageUrlKey = 'user_image_url';

  // ─── Request Token ───────────────────────────────
  Future<String?> getUserRequestToken() => 
      storage.read(key: _requestTokenKey);

  Future<void> setUserRequestToken(String token) => 
      storage.write(key: _requestTokenKey, value: token);

  // ─── Session ID ──────────────────────────────────
  Future<String?> getUserSessionId() => 
      storage.read(key: _sessionIdKey);

  Future<void> setUserSessionId(String sessionId) => 
      storage.write(key: _sessionIdKey, value: sessionId);

  // ─── User ID ─────────────────────────────────────
  Future<String?> getUserId() => 
      storage.read(key: _userIdKey);

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
    final data = await readUserData() ;
    if (data == null) return "";
    final usermodel = UserModel.fromJson(data);
    return usermodel.avatarPath! ;
  
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