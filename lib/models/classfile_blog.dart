class BlogPost {
  final int id;
  final String title;
  final String imageUrl;

  BlogPost({required this.id, required this.title, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': imageUrl,
    };
  }

  factory BlogPost.fromMap(Map<String, dynamic> map) {
    return BlogPost(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
    );
  }
}
