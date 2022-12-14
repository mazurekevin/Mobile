import 'dart:convert';

List<User> listUserFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  int id;
  String username;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
  };
}