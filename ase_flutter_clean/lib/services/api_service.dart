import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  // 🔴 CHANGE THIS to your InfinityFree domain
  static const String baseUrl =
      "https://yourdomain.infinityfreeapp.com/api";

  /// Register new user (after Firebase login)
  static Future<bool> registerUser(UserModel user) async {
    final url = Uri.parse("$baseUrl/register_user.php");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'] == true || data['status'] == 1;
    } else {
      throw Exception("Failed to register user");
    }
  }

  /// Get user profile by email
  static Future<UserModel?> getUserProfile(String email) async {
    final url = Uri.parse("$baseUrl/get_profile.php?email=$email");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {
        return UserModel.fromJson(data['user']);
      }
    }
    return null;
  }

  /// Update user profile
  static Future<bool> updateProfile(UserModel user) async {
    final url = Uri.parse("$baseUrl/update_profile.php");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'] == true;
    }
    return false;
  }

  /// Check if user already registered
  static Future<bool> isUserRegistered(String email) async {
    final url = Uri.parse("$baseUrl/check_user.php?email=$email");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['registered'] == true;
    }
    return false;
  }
}
