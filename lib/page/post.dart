import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/posts.dart';
import 'package:mobile/page/home_page.dart';
import 'package:mobile/page/origin_post.dart';
import 'package:mobile/page/profile_page.dart';
import 'package:mobile/service/service_post.dart';
import 'package:mobile/utils/globale.dart' as g;
import 'package:mobile/widgets/btn_widget.dart';

import 'nav_page.dart';

class PostDetails extends StatefulWidget {
  const PostDetails(this.post);

  final Post post;

  @override
  State<PostDetails> createState() => _PostDetailsState(this.post);
}

class _PostDetailsState extends State<PostDetails> {
  Post post;
  Post? post2;

  _PostDetailsState(this.post);

  var isLoaded = false;

  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  //late List<Comment>  comments;
  /*@override
  void initState() {
    super.initState();
    getComments();
  }
  getComments() async {
    comments = post.comments;
    if (comments != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }*/

  getPost(int id) async{
    post2 = (await ServicePost().getPostById(id))!;
    if(post2!=null){
      Navigator.push(context,
          MaterialPageRoute<void>(
              builder:(BuildContext context) {
                return PostDetails(post2!);
              }));
    }else{
      print("erreur");
    }
  }

  Future<void> sendMessage(int id, String body) async {
    var response = await ServicePost().addComment(id, body);
    if (response == 201) {
      post.comments.add(new Comment(id: post.comments.length + 1, username: g.username.toString(), body: body));
    } else {
      print("erreur");
    }
  }


  Future<void> deletePost() async {
    var response = await ServicePost().deletePost(post);
    if (response == 200) {
      Navigator.push(context,
          MaterialPageRoute<void>(
              builder:(BuildContext context) {
                return NavePage(title: "title");
              }));
    } else {
      print("erreur");
    }
  }

  Future<void> SavePost() async {
    var response = await ServicePost().savePost(post);
    if (response == 201) {
      print("create");
    } else {
      print("erreur");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Text(
                                post.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              post.language,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              post.caption,
                              style: TextStyle(fontSize: 15),
                            ),

                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark),
                            iconSize: 30.0, onPressed: () { SavePost(); },
                          ),
                          post.name == g.username ?
                          IconButton(
                            icon: 
                            Icon(Icons.delete),
                            iconSize: 30.0, onPressed: () {deletePost(); },
                          ):const Text(""),
                          post.originId != null ?
                          IconButton(icon: Icon(Icons.keyboard_return),
                            iconSize: 30.0,
                            onPressed: () {
                            getPost(post.originId);
                            },
                          ):const Text(""),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: double.infinity,
                        //height: 400.0,
                        color: Colors.black54,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            post.code,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      /*Visibility(
                    visible: isLoaded,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child:*/
                      Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            for (var comment in post.comments)
                              InkWell(
                                child: Card(
                                  color: Colors.grey[100],
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      //print("Je clique sur: ${comment.username}");
                                                      Navigator.push(context,
                                                          MaterialPageRoute<void>(
                                                              builder: (BuildContext context) {
                                                                return ProfilePage(comment.username);
                                                              }));
                                                    },
                                                    child: Text(
                                                      comment.username,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[900]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 5.0, top: 10.0),
                                                child: Text(comment.body)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ),
                          ],
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -2),
                  blurRadius: 6.0,
                ),
              ],
              color: Colors.black54,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                  hintText: 'Add a comment',
                  prefixIcon: Container(
                    margin: EdgeInsets.all(4.0),
                    width: 48.0,
                    height: 48.0,
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 4.0),
                    width: 70.0,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 30.0,
                      onPressed: () {setState(() {

                      });
                        sendMessage(post.id, messageController.text);
                        messageController.clear();
                      Navigator.push(context,
                          MaterialPageRoute<void>(builder: (BuildContext context) {
                            return PostDetails(post);
                          }));
                        },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),


      ),

    );

  }
}
