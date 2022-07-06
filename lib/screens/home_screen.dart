import 'package:comic_viewer_app/screens/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:comic_viewer_app/GetCurrentItem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String num = '';
  String name = '';
  String image = '';
  bool loading = false;
  int a = 0;
  bool b = true;

  var currentItem = CurrentItem();

  @override
  void initState() {
    getCurrentData(a);
    super.initState();
  }

  void getCurrentData(int s) async {
    var currentData = await currentItem.getCurrentItem(b, s);
    setState(() {
      b = false;
      name = currentData['title'];
      num = currentData['num'].toString();
      a = currentData['num'].toInt();

      image = currentData['img'];
      loading = true;
    });
  }

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
            icon: const Icon(
              Icons.heart_broken_rounded,
              color: Colors.red,
              size: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    padding: const EdgeInsets.only(left: 10, top: 30),
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
            loading
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    width: double.infinity,
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(
                              image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              num,
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                a--;
                                loading = false;
                                getCurrentData(a);
                              });
                            },
                            icon: Icon(Icons.arrow_back_outlined))
                      ],
                    ),
                  )
                : const SpinKitDoubleBounce(
                    color: Colors.black,
                    size: 100,
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.black45,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black45,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: ''),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (val) {},
      ),
    );
  }
}
