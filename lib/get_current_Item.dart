import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart'as dom;
import 'package:html/parser.dart' as parser;

class CurrentItem {

  Future getExplanation(String itemNumber)async{
    String title='';
    try {
      var url = Uri.parse('https://www.explainxkcd.com/wiki/index.php/'+ itemNumber);
      final res = await http.get(url);
      dom.Document document = parser.parse(res.body);

      var element = document.getElementsByClassName('mw-parser-output');

      title = element.map((e) => e.getElementsByTagName('p')[0].innerHtml).toString();

      return title;
    }catch (e){
      print('no explanation');
    }
  }


  Future getCurrentItem(String i) async {
    try {

    var url = Uri.parse('https://xkcd.com/$i/info.0.json');
    http.Response response = await http.get(url);

    var itemData = jsonDecode(response.body);
    return itemData;
  }
  catch (e){
      print('error1');
  }
  }


      }










