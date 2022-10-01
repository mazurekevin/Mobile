import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/service/service_post.dart';

import '../models/posts.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();



}

  class _HomePageState extends State<HomePage>{
  List<Post>? posts;
  List<User>? users;
  var isLoaded = false;


  @override
  void initState() {
    super.initState();
    getData();
  }



  getData() async{
    posts = await ServicePost().getPosts();
    if(posts!=null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder( itemCount:posts?.length ,itemBuilder: (context, index){

          return Container(
            child: Text(posts![index].caption),
          );
        }),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
