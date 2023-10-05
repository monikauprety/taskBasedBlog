import 'package:flutter/foundation.dart';

class FavouriteItemProvider with ChangeNotifier {
  List<int> _selectedBlog = [];
  List<int> get selectedItem => _selectedBlog;
  void addItem(int value) {
    _selectedBlog.add(value);
    notifyListeners();
  }

  void removeItem(int value) {
    _selectedBlog.remove(value);
    notifyListeners();
  }
}
