import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/follow.dart';
import 'package:mobile/page/post.dart';
import 'package:mobile/page/post_page.dart';
import 'package:mobile/page/save_post_page.dart';
import 'package:mobile/service/service_follow.dart';
import 'package:mobile/service/service_user.dart';
import 'package:mobile/utils/globale.dart' as g;
import '../models/posts.dart';
import '../models/user.dart';
import '../service/service_post.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.username);
  final String? username;
  @override
  State<ProfilePage> createState() => _ProfilePageState(this.username);
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  _ProfilePageState(this.username);

  List<Post>? posts;
  User? user;
  List<Follow>? follow;
  var isLoaded = false;
  var check = false;
  //var isLoaded = false;
  var endCheck = false;
  var endUser = false;
  var endFollow = false;
  var endPost = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    Requete();
  }



  Requete() async{
    follow = await ServiceFollow().getFollowsByName(this.username);
    posts = await ServicePost().getPostsByName(this.username);
    user = await ServiceUser().getUserByName(this.username);
    check = (await ServiceFollow().checkFollow(username))!;
    if (follow != null && posts != null && user != null && check != null ) {
      setState(() {
        isLoaded = true;
      });
    }
  }


  deleteFollow(String? username) async {
    int? response = await ServiceFollow().deleteFollow(username);
  }

  addFollow(String? username) async{
    int? response = await ServiceFollow().createFollow(username);

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Visibility(
            visible: isLoaded,
            child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 80,
                                    ),
                                     Text(
                                      user?.username ?? '',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Following',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              follow?.length.toString() ?? '0',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Post',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              posts?.length.toString() ?? '0' ,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                          IconButton(
                                          icon: user?.username == g.username ?
                                          Icon(Icons.bookmark): check == false ?
                                          Icon(Icons.person_add) : Icon(Icons.person_remove),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            user?.username == g.username ?
                                            Navigator.push(context,
                                                MaterialPageRoute<void>(builder: (BuildContext context) {
                                                  return SavePostPage(user?.username);
                                                })):check == false ?
                                             addFollow(user?.username): deleteFollow(user?.username);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                      child: ListView.builder(
                        itemCount: posts?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        posts![index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        posts![index].caption ?? '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                        return PostDetails(posts![index]);
                                      }));
                            },

                          );
                        },
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
        ),
      ],
    );
  }
}
