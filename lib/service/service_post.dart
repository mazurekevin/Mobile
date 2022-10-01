import 'package:flutter/material.dart';
import 'package:mobile/models/posts.dart';
import 'package:http/http.dart' as http;

class ServicePost{
  Future<List<Post>?> getPosts() async{
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.81:8081/api/posts');

    var response = await client.get(uri);
    if(response.statusCode==200){
      var json = response.body;
      return postFromJson(json);
    }
    return null;
  }
}