import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/save_post.dart';
import 'package:mobile/page/post.dart';
import 'package:mobile/page/save_post_details.dart';

import '../service/service_post.dart';

class SavePostPage extends StatefulWidget {
  const SavePostPage(this.username);
  final String? username;

  @override
  State<SavePostPage> createState() => _SavePostPageState(this.username);
}

class _SavePostPageState extends State<SavePostPage> {
  String? username;
  _SavePostPageState(this.username);
  List<SavePost>? savePosts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    savePosts = await ServicePost().getSavePostsByName(username!);
    if (savePosts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back),
          title: const Text('My Save Post'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: savePosts?.length,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(40.0),
              child: Container(
                margin: EdgeInsets.all(10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            savePosts![index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            savePosts![index].caption ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          savePosts![index].language ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      return SavePostDetails(savePosts![index]);
                    }));
              },
            );
          },
        ),
      ),
    );
  }
}
