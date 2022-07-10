import 'package:flutter/material.dart';
import 'package:comic_viewer_app/screens/detail_screen.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({ this.favoriteItem,});
  final favoriteItem;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();

}
class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    List favoriteItemDetail=widget.favoriteItem;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: favoriteItemDetail.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index){
            String name =favoriteItemDetail[index]['title'];
            String image=favoriteItemDetail[index]['img'];
            return Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(
                      detailItem: favoriteItemDetail[index],
                    );
                  }));
                },
                child: Card(
                  shadowColor: Colors.grey ,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 70,
                        height: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.network(image),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(name,style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      IconButton(onPressed: (){
                        setState((){
                          favoriteItemDetail.removeAt(index);
                        });


                      }, icon: Icon(
                        Icons.delete
                      ),),
                    ],
                  ),
                ),
              ),
            );
            }
        ),
      ),
    );
  }
}
