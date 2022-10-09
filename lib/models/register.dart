import 'dart:convert';

List<Register> userFromJson(String str) => List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));

String userToJson(List<Register> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register {
  Register({
    required this.username,
    required this.email,
    required this.password,
  });

  String username;
  String email;
  String password;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
  };
}