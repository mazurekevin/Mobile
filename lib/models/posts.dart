import 'dart:convert';

List<Post> ListPostFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.name,
    required this.caption,
    required this.code,
    required this.language,
    required this.likeCount,
    required this.originId,
    required this.originName,
    required this.comments,
  });

  int id;
  String name;
  String caption;
  String code;
  String language;
  int likeCount;
  dynamic originId;
  String originName;
  List<Comment> comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    name: json["name"],
    caption: json["caption"],
    code: json["code"],
    language: json["language"],
    likeCount: json["likeCount"],
    originId: json["originId"],
    originName: json["originName"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "caption": caption,
    "code": code,
    "language": language,
    "likeCount": likeCount,
    "originId": originId,
    "originName": originName,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    required this.id,
    required this.username,
    required this.body,
  });

  int id;
  String username;
  String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    username: json["username"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "body": body,
  };
}
