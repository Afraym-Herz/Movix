import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movix/features/auth/data/models/user_model.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<String?> getUserId() => storage.read(key: "userId");

  Future<void> setUserId(String userId) => storage.write(key: "userId", value: userId);

Future<void> writeData({
    required String key,
    required String value,
  }) async {
    String? existingValue = await storage.read(key: key);
    if (existingValue == null) {
      await storage.write(key: key, value: value);
    }
  }

  Future<void> writeUserData({
    required String key,
    required UserModel userModel,
  }) async {
      await storage.write(key: key, value: jsonEncode(userModel.toMap()));
  }


  Future<Map<String, dynamic>?> readUserData({required String uId }) async {

    String? existingValue = await storage.read(key: uId );
    if (existingValue != null) {
      return jsonDecode(existingValue);
    }

    return null;
  }

  Future<void> deleteUserData({required String uId }) async {
    await storage.delete(key: uId);  
  }

   Future<String?> getAccessToken() => storage.read(key: "accessToken");
   Future<String?> getRefreshToken() => storage.read(key: "refreshToken");

   Future setAccessToken(String token) => storage.write(key: "accessToken", value: token);
   Future setRefreshToken(String token) => storage.write(key: "refreshToken", value: token);

   Future clearTokens() async {
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }

  

  Future<void> deleteData({required String key}) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }
}
