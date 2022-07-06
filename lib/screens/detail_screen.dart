import 'package:flutter/material.dart';
import 'package:comic_viewer_app/Services.dart';



class DetailPage extends StatefulWidget {
   DetailPage({this.detailItem,this.iteamcount});
   final detailItem;
   final iteamcount;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {






  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('D'),
      ),
      body: SizedBox(),
    );
  }
}
