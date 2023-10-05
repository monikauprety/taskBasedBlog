import 'package:flutter/material.dart';
import 'package:taskblog/models/getAll_blogs.dart';

class SelectedBlogs extends StatefulWidget {
  final Blogs post;
  SelectedBlogs({super.key, required this.post});

  @override
  State<SelectedBlogs> createState() => _SelectedBlogsState();
}

class _SelectedBlogsState extends State<SelectedBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Blog"),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child:
                    Container(child: Image.network("${widget.post.imageUrl}")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " ${widget.post.title}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
