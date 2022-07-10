import 'package:flutter/material.dart';
import 'package:comic_viewer_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:comic_viewer_app/providers/my_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFB71C1C)
        ), appBarTheme:const AppBarTheme(
          color: Colors.amber),),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MyProvider>(
        create: (_)=> MyProvider(),
          child: const MyHomePage()),
    );
  }
}
