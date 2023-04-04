import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';


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

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  var scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('끝임');

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(itemCount: widget.data.length, controller: scroll,itemBuilder: (c, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.data[i]['image'],),
            Text('좋아요 ${widget.data[i]['likes'].toString()}'),
            Text(widget.data[i]['user']),
            Text(widget.data[i]['content'])
          ],
        );
      });
    }

    return CircularProgressIndicator();
  }
}


class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));

    if (result.statusCode != 200) {
      throw Exception('초기 데이터를 불러오지 못했습니다.');
    }

    setState(() {
      data = jsonDecode(result.body);
      print(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
        HomeBody(data : data),
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

