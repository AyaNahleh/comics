import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier{
  List <String>test=[];

  void apply(String name){

    test.add(name);
    notifyListeners();
  }

}