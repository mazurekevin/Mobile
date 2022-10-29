import 'dart:convert';
import 'package:mobile/utils/globale.dart' as g;
import 'package:flutter/material.dart';
import 'package:mobile/models/posts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/save_post.dart';

class ServicePost{
  Future<List<Post>?> getPosts() async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/posts');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return ListPostFromJson(json);
    }
    return null;
  }

  Future<List<Post>?> getPostsByName(String? username) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/posts/user/${username}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return ListPostFromJson(json);
    }
    return null;
  }

  Future<Post?> getPostById(int id) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/posts/${id}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return postFromJson(json);
    }
    return null;
  }

  Future<int?> deletePost(Post post) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/posts/${post.id}');

    var response = await client.delete(uri);
    if(response.statusCode==200){
      return response.statusCode;
    }
    return null;
  }


  Future<List<SavePost>?> getSavePostsByName(String username) async{
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8080/api/SavePosts/user/${username}');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return listSavePostFromJson(json);
    }
    return null;
  }

  Future<int?> savePost(Post post) async{

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/SavePosts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'myPseudo': g.username,
        'name': post.name,
        'caption': post.caption,
        'code': post.code,
        'language': post.language,
        'likes': post.likeCount.toString(),
        'originId': post.originId,
        'originName': post.originName
      }),
    );


    if(response.statusCode==201){
      return response.statusCode;
    }else{
      return response.statusCode;
    }

  }

  Future<int?> addComment(int id, String body) async{

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/posts/${id}/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String?>{
        'username': g.username,
        'body': body,
      }),
    );


    if(response.statusCode==201){
      return response.statusCode;
    }else{
      return response.statusCode;
    }

  }

}