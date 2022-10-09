import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/posts.dart';

class PostPage extends StatelessWidget {
  Post post;

  PostPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Détails du post:"),
      ),
      body: Container(
        child:Column(
          children:<Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(text: post.name),
                TextSpan(text: post.language),
              ]),
            ),
            Text(
                post.code
            ),

                Column(
                  children:<Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: post.name),
                        TextSpan(text: post.language),
                      ]),
                    ),
                    Text(
                        post.code
                    ),
                  ],
                )

          ],
        ),
      ),
    );
  }
}