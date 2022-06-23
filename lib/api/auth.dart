import 'dart:convert';
import 'package:food_app/api/api.dart';
import 'package:http/http.dart' as http;

class AuthAPI extends BaseAPI {
  Future<http.Response> signUp(String name, String email, String phone,
      String address, String password, String passwordConfirmation) async {
    var body = jsonEncode({
      'user': {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    });
    http.Response response = await http.post(Uri.parse(super.signupPath),
        headers: super.headers, body: body);
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    http.Response response = await http.post(Uri.parse(super.signinPath),
        headers: super.headers, body: body);

    return response;
  }

  Future<http.Response> logout(String token) async {
    var body = jsonEncode({'accessToken': token});

    http.Response response =
        await http.get(Uri.parse(super.logoutPath), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    return response;
  }
}
