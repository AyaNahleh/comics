import 'dart:io';
import 'package:flutter/material.dart';
import 'package:comic_viewer_app/get_current_Item.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';




class DetailPage extends StatefulWidget {
  DetailPage({@required this.detailItem});
  final detailItem;
  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {

  var currentItem = CurrentItem();
  String num = '';
  String title = '';
  String image = '';
  String alt = '';
  String transcript = '';
  String explanation = '';
  bool isFound = true;
  var detailData={};
  String year='';
  String day='';
  String month='';


  @override
  void initState() {
    updateItem();
    getExplanation();
    super.initState();
  }


  Future getExplanation() async {
    try {
      var explanationItem = await currentItem.getExplanation(num);
      setState(() {
        explanation = explanationItem;
        isFound =true;
      });
    }catch (e){
      isFound=false;
    }
  }

  void updateItem() {

    setState(() {
      detailData = widget.detailItem;
      title = detailData['title'];
      image = detailData['img'];
      alt = detailData['alt'];
      transcript = detailData['transcript'];
      num = detailData['num'].toString();
      year=detailData['year'];
      month=detailData['month'];
      day=detailData['day'];
    });

  }
  void getItemDate(String y,String m,String d){

    // DateTime c=DateTime.parse(' ');
    // print(c);

  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () async {
                final uri = Uri.parse(image);
                final res = await http.get(uri);
                final bytes = res.bodyBytes;
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes);
                await Share.shareFiles([path]);
              },
              icon: const Icon(
                Icons.share,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              InteractiveViewer(

                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    image,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                alt,
                style: const TextStyle(color: Colors.black45, fontSize: 10),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemDescription(data: num,nameDescription: 'Number',),
                  itemDescription(data: title,nameDescription: 'Name',),
                  itemDescription(data: '$year/$month/$day',nameDescription: 'Date',),
                  itemDescription(data: transcript!=''?transcript:'No transcript found',nameDescription: 'Transcript',),


                ],
              ),


              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xFFB71C1C),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Explanation',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(explanation),
                      )
                    ],
                  ),
                );
              });
        },
        child: const Text(
          'More',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class itemDescription extends StatelessWidget {
  const itemDescription({
    Key? key,
    required this.data,required this.nameDescription,
  }) : super(key: key);
final String nameDescription;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [

              Text('$nameDescription:',style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              const SizedBox(width: 5,),
              Expanded(child: Text(data,style: const TextStyle(fontSize: 15),)),

            ],
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 1,
            width: 220,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
