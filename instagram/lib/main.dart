import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;


void main() {
  runApp(
    MaterialApp(
      theme: style.theme,
      home: MyApp()
    )
  );
}

const textBlack = TextStyle(color: Colors.black);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('assets/images/IMG_0205.PNG'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              Text('좋아요 100'),
              Text('글쓴이'),
              Text('글내용!!'),
            ],
          ),
        )
      ],
    );
  }
}


class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
          title: Text('Instagram', style: textBlack,),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_box_outlined),
                iconSize: 30,
            )
          ],
        ),
      body: [
        HomeBody(),
        Text('shop')
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈', ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ],
      ),
    );
  }
}

