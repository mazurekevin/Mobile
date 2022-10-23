import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/posts.dart';
import 'package:mobile/service/service_post.dart';

class PostDetails extends StatefulWidget {
  const PostDetails(this.post);

  final Post post;

  @override
  State<PostDetails> createState() => _PostDetailsState(this.post);
}

class _PostDetailsState extends State<PostDetails> {
  Post post;

  _PostDetailsState(this.post);

  var isLoaded = false;

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
  Future<void> deletePost() async {
    var response = await ServicePost().deletePost(post);
    if (response == 200) {
      print("delete");
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
                                  icon: Icon(
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
                      Container(
                        child: Text(
                          post.caption,
                          style: TextStyle(fontSize: 15),
                        ),
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
                                                      /*Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ));*/
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
      ),
    );
  }
}
