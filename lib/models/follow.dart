import 'dart:convert';

Follow followFromJson(String str) => Follow.fromJson(json.decode(str));
List<Follow> ListFollowFromJson(String str) => List<Follow>.from(json.decode(str).map((x) => Follow.fromJson(x)));

String followToJson(Follow data) => json.encode(data.toJson());

class Follow {
  Follow({
    required this.id,
    required this.followerUserName,
    required this.followedUserName,
  });

  int id;
  String followerUserName;
  String followedUserName;

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    id: json["id"],
    followerUserName: json["followerUserName"],
    followedUserName: json["followedUserName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "followerUserName": followerUserName,
    "followedUserName": followedUserName,
  };
}