import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/http_exception.dart';
import 'package:flutter_complete_guide/keys.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSgement) async {
    final Uri url = Uri(
        scheme: 'https',
        host: 'identitytoolkit.googleapis.com',
        path: '/v1/accounts:$urlSgement',
        queryParameters: {'key': firebase_key});
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
