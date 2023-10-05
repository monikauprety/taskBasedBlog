import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskblog/models/getAll_blogs.dart';
import 'package:taskblog/provider/favourite_blog_provider.dart';
import 'package:taskblog/screens/selected_blogs.dart';
import 'package:taskblog/view_models/getblog_view_model.dart';

class FavouriteBlogs extends StatefulWidget {
  const FavouriteBlogs({super.key});

  @override
  State<FavouriteBlogs> createState() => _FavouriteBlogsState();
}

class _FavouriteBlogsState extends State<FavouriteBlogs> {
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final favouriteProvider = Provider.of<FavouriteItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("List of all Favourite Blogs"),
      ),
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
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: favouriteProvider.selectedItem.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.blogs![index];
                              return Consumer<FavouriteItemProvider>(
                                  builder: (context, value, child) {
                                return SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (value.selectedItem
                                                .contains(index)) {
                                              value.removeItem(index);
                                            } else {
                                              value.addItem(index);
                                            }
                                            //Navigate to the PostDetailScreen when a post is clicked
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
                                        child: Card(
                                          elevation: 2,
                                          color: Colors.white70,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            alignment: Alignment.bottomCenter,
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
                                                    snapshot.data!.blogs![index]
                                                        .title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          );
                        }
                      }),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
