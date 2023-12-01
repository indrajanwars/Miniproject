import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject/provider/config.dart';
import 'package:miniproject/session.dart';

class AuthProvider extends ChangeNotifier {
  Future<dynamic> register(String email, String username, String jenisKelamin,
      String tanggalLahir, String password, String name) async {
    try {
      final url = Uri.parse("${Config.endPoint}/auth-service/auth/register");
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "username": username,
            "jenisKelamin": jenisKelamin,
            "tanggalLahir": tanggalLahir,
            "password": password,
            "name": name,
          }));

      final result = jsonDecode(response.body);
      print(result);
      if (result['message'] == "Success") {
        await Session.set(Session.tokenSessionKey, result['data']["token"]);
      }
      return result;
    } catch (e) {
      print("Terjadi Kesalahan: $e");
      return null;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final url = Uri.parse("${Config.endPoint}/auth-service/auth/login");
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "emailorusername": email,
            "password": password,
          }));

      final result = jsonDecode(response.body);
      print(result);
      if (result['message'] == "Success") {
        await Session.set(Session.tokenSessionKey, result['data']["token"]);
      }
      return result;
    } catch (e) {
      print("Terjadi Kesalahan: $e");
      return null;
    }
  }
}
