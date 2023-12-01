import 'dart:convert';

import 'package:miniproject/provider/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../session.dart';

class AuthProvider extends ChangeNotifier {
  Future<dynamic> register(String email, String username, String jenisKelamin,
      String tanggalLahir, String password, String name) async {
    try {
      final url = Uri.parse(
          "http://34.125.215.71:8080/api/v1/auth-service/auth/register");
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "username": username,
            "jenisKelamin": jenisKelamin,
            "tanggalLahir": tanggalLahir,
            "password": password,
            "name": name
          }));

      print("${response.body}");

      final result = json.decode(response.body);

      if (response.statusCode == 201) {
        return result;
      } else {
        print("${result}");
        return result;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      return null;
    }
  }

  Future<dynamic> login(String email, String password) async {
    final url = Uri.parse('${Config.endPoint}/auth-service/auth/login');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emailorusername': email, 'password': password}));

    print('${url} ${response.body}');
    final result = json.decode(response.body);

    if (result['message'] == 'Success') {
      // await Session.set(Session.USERID_SESSION_KEY, email);
      await Session.set(Session.tokenSessionKey, result['data']['token']);
      // await Session.set(Session.PASSWD_KEY, password);
      return result;
    } else {
      return result;
    }
  }
}
