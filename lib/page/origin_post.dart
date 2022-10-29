import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/page/profile_page.dart';
import 'package:mobile/service/service_post.dart';
import 'package:mobile/utils/globale.dart' as g;
import '../models/posts.dart';
import 'nav_page.dart';

class OriginPostPage extends StatefulWidget {
  const OriginPostPage(this.id);
  final int id;
  @override
  State<OriginPostPage> createState() => _OriginPostPageState(this.id);
}

class _OriginPostPageState extends State<OriginPostPage> {
  int id;
  _OriginPostPageState(this.id);
  var isLoaded = false;
  Post? post;
  @override
  void initState() {
    super.initState();

    //fetch data from API
    getPost();
  }
  getPost() async{
    post = await ServicePost().getPostById(id);
    if(post!=null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  Future<void> deletePost() async {
    var response = await ServicePost().deletePost(post!);
    if (response == 200) {
      print("delete");
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
    var response = await ServicePost().savePost(post!);
    if (response == 201) {
      print("create");
    } else {
      print("erreur");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child:  Column(
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
                                post!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              post!.language,
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
                              post!.caption,
                              style: TextStyle(fontSize: 15),
                            ),

                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark),
                            iconSize: 30.0, onPressed: () { SavePost(); },
                          ),
                          post!.name == g.username ?
                          IconButton(
                            icon:
                            Icon(Icons.delete),
                            iconSize: 30.0, onPressed: () {deletePost(); },
                          ):Text(""),
                          post!.originId != null ?
                          IconButton(icon: Icon(Icons.keyboard_return),
                            iconSize: 30.0,
                            onPressed: () {  },
                          ):Text(""),
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
                            post!.code,
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
                            for (var comment in post!.comments)
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
      ),
    );
  }
}
