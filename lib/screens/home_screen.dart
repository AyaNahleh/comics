import 'package:comic_viewer_app/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:comic_viewer_app/screens/detail_screen.dart';
import 'package:comic_viewer_app/screens/favorite_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
            },
            icon: const Icon(Icons.heart_broken_rounded,color: Colors.red,
            size: 40,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.27,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.24,
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36))),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 30),
                    child: const Text(
                      'welcome !!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: const Text(
                "what's new",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            viewer_item(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "We have all different types",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:  (context)=>FavoriteScreen()));
                      },
                      child: Text('more'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                      ),
                    )
                  ]),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  viewer_item(),
                  viewer_item(),
                  viewer_item(),
                  viewer_item(),
                ],
              ),
            ),


          ],
        ),
      ),

    );
  }
}

class viewer_item extends StatefulWidget {
  const viewer_item({
    Key? key,
  }) : super(key: key);

  @override
  State<viewer_item> createState() => _viewer_itemState();
}

class _viewer_itemState extends State<viewer_item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 150,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(3, 7), color: Colors.grey, blurRadius: 10)
          ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailPage()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://picsum.photos/250?image=9',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('name'),
                Icon(
                  Icons.arrow_forward_outlined,
                  size: 20,
                )
              ],
            ),
            Text('num')
          ],
        ),
      ),
    );
  }
}
