
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/models/current_user.dart';

import '../models/login.dart';
import '../models/register.dart';

class ServiceUser{
  Future<Response> createUser(Register register) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.81:8081/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': register.username,
        'email': register.email,
        'password': register.password
      }),
    );

    return response;
  }

  Future<CurrentUser?> login(Login login) async {
    var response = await http.post(
      Uri.parse('http://192.168.1.81:8081/api/auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': login.username,
        'password': login.password
      }),
    );
    if(response.statusCode==200){
      var json = response.body;
      return currentUserFromJson(json);
    }

    return null;
  }

}