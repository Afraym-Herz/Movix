import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjc4NDI1OWY1NGI4MTJiMjE4MjkzZjdlMTljZmI1OCIsIm5iZiI6MTc3MDc1Nzc4MS41NjA5OTk5LCJzdWIiOiI2OThiOWU5NTM5ZTE5N2QwZjMxZTY2MjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.eK3t9F0o6HFHAk7jLWmzxIUHzrwAuWUX78y7wJD7asA';

  Future<String?> login(String username, String password) async {
    final headers = {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    try {
      final tokenResponse = await http.get(
        Uri.parse('$_baseUrl/authentication/token/new'),
        headers: headers,
      );
      final requestToken = jsonDecode(tokenResponse.body)['request_token'];

      final loginResponse = await http.post(
        Uri.parse('$_baseUrl/authentication/token/validate_with_login'),
        headers: headers,
        body: jsonEncode({
          'username': username,
          'password': password,
          'request_token': requestToken,
        }),
      );

      if (jsonDecode(loginResponse.body)['success'] != true) {
        throw Exception("Login failed: Invalid username or password");
      }
      final sessionResponse = await http.post(
        Uri.parse('$_baseUrl/authentication/session/new'),
        headers: headers,
        body: jsonEncode({'request_token': requestToken}),
      );

      final sessionId = jsonDecode(sessionResponse.body)['session_id'];
      await _saveSessionId(sessionId);
      
      return sessionId;
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('session_id');
      if (sessionId != null) {
        final headers = {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        };
        await http.delete(
          Uri.parse('$_baseUrl/authentication/session'),
          headers: headers,
          body: jsonEncode({'session_id': sessionId}),
        );
      }
      await _clearSessionId();
    } catch (e) {
      await _clearSessionId();
      throw Exception("Error during logout: $e");
    }
  }

  Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  Future<bool> isLoggedIn() async {
    final sessionId = await getSessionId();
    return sessionId != null;
  }

  Future<void> _saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
  }

  Future<void> _clearSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
  }

  String get signupUrl => 'https://www.themoviedb.org/signup';
}
