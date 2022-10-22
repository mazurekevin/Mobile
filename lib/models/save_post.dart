import 'dart:convert';

SavePost savePostFromJson(String str) => SavePost.fromJson(json.decode(str));

String savePostToJson(SavePost data) => json.encode(data.toJson());

class SavePost {
  SavePost({
    required this.savePostId,
    required this.myPseudo,
    required this.name,
    required this.caption,
    required this.code,
    required this.language,
    required this.likeCount,
    required this.originId,
    required this.originName,
  });

  int savePostId;
  String myPseudo;
  String name;
  String caption;
  String code;
  String language;
  int likeCount;
  dynamic originId;
  String originName;

  factory SavePost.fromJson(Map<String, dynamic> json) => SavePost(
    savePostId: json["savePostId"],
    myPseudo: json["MyPseudo"],
    name: json["name"],
    caption: json["caption"],
    code: json["code"],
    language: json["language"],
    likeCount: json["likeCount"],
    originId: json["originId"],
    originName: json["originName"],
  );

  Map<String, dynamic> toJson() => {
    "savePostId": savePostId,
    "MyPseudo": myPseudo,
    "name": name,
    "caption": caption,
    "code": code,
    "language": language,
    "likeCount": likeCount,
    "originId": originId,
    "originName": originName,
  };
}
