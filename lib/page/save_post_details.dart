import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/save_post.dart';

class SavePostDetails extends StatefulWidget {
  const SavePostDetails(this.savePost);
  final SavePost savePost;
  @override
  State<SavePostDetails> createState() => _SavePostDetailsState(this.savePost);
}

class _SavePostDetailsState extends State<SavePostDetails> {
  SavePost savePost;
  _SavePostDetailsState(this.savePost);
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
                                savePost.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              savePost.language,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          savePost.caption,
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
                            savePost.code,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
