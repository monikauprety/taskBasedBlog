import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskblog/provider/favourite_blog_provider.dart';
import 'package:taskblog/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavouriteItemProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}
