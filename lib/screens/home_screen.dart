import 'package:flutter/material.dart';
import 'package:comic_viewer_app/get_current_Item.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:comic_viewer_app/screens/detail_screen.dart';
import 'package:string_validator/string_validator.dart';
import 'package:comic_viewer_app/screens/favorite_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();

  String num = '';
  String image = '';
  bool loading = false;
  int totalLength = 0;
  Map currentData = {};
  bool isError = false;
  bool checkItem = false;
  List favorite = [];


  var currentItem = CurrentItem();


  @override
  void initState() {
    getCurrentLength();
    getCurrentData(num);
    super.initState();
  }

  void getCurrentLength() async {
    var getLength = await currentItem.getCurrentItem(num);
    setState(() {
      totalLength = getLength['num'].toInt();
    });
  }

  void getCurrentData(String data) async {
    try {
      var current = await currentItem.getCurrentItem(data);
      setState(() {
        currentData = current;
        num = currentData['num'].toString();
        image = currentData['img'];
        loading = true;
        isError = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
  }

  void browsComics(String number) {
    int numb = int.parse(number);
    checkItem ? numb++ : numb--;
    String num = numb.toString();
    getCurrentData(num);
  }

  bool checkNumber(String text, int num) {
    if (isNumeric(text)) {
      int test = int.parse(text);
      if (test == 0 || test > num) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void addItem(dynamic item) {
    setState(() {
      favorite.add(item);
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
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
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            hintText: 'Enter the comic number',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: isError ? 'no comics found' : null),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        onFieldSubmitted: (val) {
                          checkNumber(val, totalLength)
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'unvalid number',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    duration: const Duration(seconds: 10),
                                    action: SnackBarAction(
                                      label: 'close',
                                      onPressed: () {
                                        _cityController.clear();
                                        getCurrentData('');
                                      },
                                      textColor: Colors.black,
                                      disabledTextColor: Colors.black,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    behavior: SnackBarBehavior.floating,
                                    padding: const EdgeInsets.all(15.0),
                                    backgroundColor: Colors.amberAccent,
                                  ),
                                )
                              : getCurrentData(val);
                        },
                      ),
                    ),
                  ),
                  Image.asset('assets/app_icon.png',width: 160,height: 130,)
                ],
              ),
            ),
            loading
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    width: double.infinity,
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPage(
                                  detailItem: currentData,
                                );
                              }));
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(
                                image,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          style:  OutlinedButton.styleFrom(
                            minimumSize: const Size(20, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)

                            ),
                            backgroundColor: Colors.amberAccent

                          ),
                          onPressed: () {
                            addItem(currentData);
                          },
                          child: const Icon(Icons.favorite,color: Color(0xFFB71C1C),),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            int.parse(num) != 1
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        checkItem = false;
                                      });
                                      browsComics(num);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios))
                                : Container(),
                            int.parse(num) != totalLength
                                ? IconButton(
                                    onPressed: () {
                                      checkItem = true;
                                      browsComics(num);
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios))
                                : Container(),
                          ],
                        )
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
        backgroundColor: const Color(0xFFB71C1C),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FavoriteScreen(
                      favoriteItem: favorite,
                    );
                  }));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
              label: ''),
        ],
        currentIndex: 0,

        onTap: (val) {},
      ),
    );
  }


}


// Navigator.push(context, MaterialPageRoute(builder: (context) {
// return FavoriteScreen(
// favoriteItem: favorite,
// );
// }));
