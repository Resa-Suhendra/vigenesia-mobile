import 'dart:async';
import 'dart:convert';

import 'package:vigenesia/model/LoginResponseModel.dart';

import '../model/UserModel.dart';
import 'package:http/http.dart' as http;

class UserService {
  // static const base_url = 'http://192.168.1.8/vigenesia/api';
  static const base_url = 'https://vigenesia.org/api';

  static FutureOr<String?> register(Map<String, dynamic> user) async {
    const String url = '${base_url}/registrasi';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: user,
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        return response.body.toString();
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return null;
    }
  }

  static FutureOr<UserModel?> login(Map<String, dynamic> param) async {
    const String url = '${base_url}/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: param,
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        print(response.body.toString());
        LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(json.decode(response.body));
        return loginResponseModel.data;
      } else {
        print('Failed to submit form. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error submitting form: $error');
      return null;
    }
  }
}
