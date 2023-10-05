// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:taskblog/models/getAll_blogs.dart';

// class NewsRepository {
//   // final dbHelper = DbHelper();
//   Future<getCategoriesofBlog> fetchNewUserLineApi() async {
//     final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
//     final String adminSecret =
//         '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

//     final response = await http.get(Uri.parse(url), headers: {
//       'x-hasura-admin-secret': adminSecret,
//     });

//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       // body.forEach((item) {
//       //   dbHelper.insertData(item);
//       // });
//       return getCategoriesofBlog.fromJson(body);
//     }
//     throw Exception('Error');
//   }
// }
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskblog/models/getAll_blogs.dart';

class NewsRepository {
  Future<getCategoriesofBlog> fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return getCategoriesofBlog.fromJson(body);
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
    return fetchBlogs();
  }
}
