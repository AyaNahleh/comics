import 'package:flutter/material.dart';
import 'package:comic_viewer_app/screens/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          color: Colors.amber
        )
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
