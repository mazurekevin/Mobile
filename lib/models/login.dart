import 'dart:convert';

List<Login> userFromJson(String str) => List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));

String userToJson(List<Login> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Login {
  Login({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}