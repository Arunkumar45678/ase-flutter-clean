import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = "https://testase.gt.tc/api";

  static Future<bool> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register_user.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["status"] == 1;
    }
    return false;
  }
}
