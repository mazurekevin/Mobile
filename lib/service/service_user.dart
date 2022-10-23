import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/current_user.dart';



import '../models/login.dart';
import '../models/register.dart';
import '../models/user.dart';

class ServiceUser{
  Future<int> createUser(Register register) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': register.username,
        'email': register.email,
        'password': register.password
      }),
    );

    if(response.statusCode==200){
      return response.statusCode;
    }else{
      return response.statusCode;
    }
  }

  Future<CurrentUser?> login(Login login) async {
    var response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/signin'),
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

  Future<User?> getUserByName(String? username) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/users/getByUsername/${username}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return userFromJson(json);
    }
    return null;
  }

}