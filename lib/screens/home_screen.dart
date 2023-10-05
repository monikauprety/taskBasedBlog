import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskblog/models/getAll_blogs.dart';
import 'package:taskblog/provider/favourite_blog_provider.dart';
import 'package:taskblog/screens/allfavourite_screen.dart';
import 'package:taskblog/screens/selected_blogs.dart';
import 'package:taskblog/view_models/getblog_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  //  List<BlogPost> _blogPosts = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchNewUserLineApi();
  // }
  // Future<void> _loadDataFromDatabase() async {
  //   final blogPosts = await DatabaseHelper.instance.getAllBlogPosts();
  //   setState(() {
  //     _blogPosts = blogPosts;
  //   });
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   newsViewModel.fetchNewUserLineApi();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "All Blogs",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(children: [
                  SizedBox(
                    height: height * .90,
                    child: FutureBuilder<getCategoriesofBlog>(
                        future: newsViewModel.fetchBlogs(),
                        builder: (BuildContext context,
                            AsyncSnapshot<getCategoriesofBlog> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return Text(
                              'Error loading data',
                              style: TextStyle(color: Colors.white),
                            ); // Handle error or null data
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.blogs!.length,
                              itemBuilder: (context, index) {
                                final post = snapshot.data!.blogs![index];

                                return SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigate to the PostDetailScreen when a post is clicked
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectedBlogs(
                                                  post: post,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: height * .4,
                                            width: width * .9,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * .02),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!
                                                    .blogs![index].imageUrl
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) {
                                                  return Container(
                                                    child: Text("WAiting"),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Column(
                                          children: [
                                            Card(
                                              elevation: 2,
                                              color: Colors.white70,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Container(
                                                padding: EdgeInsets.all(15),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                height: height * .12,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * .7,
                                                      child: Text(
                                                        snapshot.data!
                                                            .blogs![index].title
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Consumer<FavouriteItemProvider>(
                                                builder: (context, value, _) {
                                              return Card(
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    if (value.selectedItem
                                                        .contains(index)) {
                                                      value.removeItem(index);
                                                    } else {
                                                      value.addItem(index);
                                                    }
                                                    // Add your button click logic here
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FavouriteBlogs()));
                                                  },
                                                  icon: Icon(Icons.favorite),
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Developed with ❣️ by Monika",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
