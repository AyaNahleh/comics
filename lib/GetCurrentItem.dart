import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
class CurrentItem {


   Future getCurrentItem(bool b,int i) async {


     var url;
     if(b==true){
        url = Uri.parse('https://xkcd.com//info.0.json');

     }if(b == false){
        url = Uri.parse('https://xkcd.com/'+i.toString()+'/info.0.json');


     }

    http.Response response = await http.get(url);
    var itemData = jsonDecode(response.body);
    return itemData ;
  }


}