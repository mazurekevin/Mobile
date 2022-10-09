import 'dart:convert';

CurrentUser currentUserFromJson(String str) => CurrentUser.fromJson(json.decode(str));

String currentUserToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  CurrentUser({
    required this.accessToken,
    required this.tokenType,
    required this.username,
  });

  String accessToken;
  String tokenType;
  String username;

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "tokenType": tokenType,
    "username": username,
  };
}