import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/follow.dart';
import 'package:mobile/utils/globale.dart' as g;

class ServiceFollow {


  Future<int?> createFollow(String? followedUserName) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/follow'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'followerUserName': g.username,
        'followedUserName': followedUserName,
      }),
    );

    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> deleteFollow(String? followedUserName) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/follow/deleteFollow'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'followerUserName': g.username,
        'followedUserName': followedUserName,
      }),
    );


    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<bool?> checkFollow(String? followedUserName) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/follow/checkFollow'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'followerUserName': g.username,
        'followedUserName': followedUserName,
      }),
    );

    print(response.body);
    if (response.body == "true") {

      return true;
    } else {
      return false;
    }
  }
  Future<List<Follow>?> getFollowsByName(String? username) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/follow/follower/${username}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return ListFollowFromJson(json);
    }
    return null;
  }
}