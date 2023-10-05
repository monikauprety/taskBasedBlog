import 'package:taskblog/models/getAll_blogs.dart';
import 'package:taskblog/repository/getAll_blogs_repo.dart';

class NewsViewModel {
  final _rep = NewsRepository();

//if internet is connected
// 1. call api from server
// 2. keep data in local
// 3. return data to response
//if internet is disconnected
// 3. call from localstorage
//bind to response

  //check whether data is present in local ro not
  Future<getCategoriesofBlog> fetchBlogs() async {
    final response = _rep.fetchBlogs();
    return response;

    //keep response in local storate if not present
    //   return response.data as List.map(blogs) {
    //     print('Inserting $blogs');
    //     DBProvider.db.createEmployee(Employee.fromJson(blogs));
    //   }.toList();
    // }
  }
}
