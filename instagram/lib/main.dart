import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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

class Home extends StatefulWidget {
  const Home({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scroll = ScrollController();
  bool requestIng = false;

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more2.json'));
    if (result.statusCode == 200) {
      requestIng = true;
    }

    if (requestIng) {
      widget.addData(jsonDecode(result.body));
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('끝임');
        getMore();
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
  var userImage;

  addData(moreData) {
    setState((){
      data.add(moreData);
    });
  }

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
                icon: Icon(Icons.add_box_outlined),
                onPressed: () async {
                  var picker = ImagePicker();
                  var image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      userImage = File(image.path);
                    });
                  }

                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Upload(userImage: userImage))
                  );
                },
                iconSize: 30,
            )
          ],
        ),
      body: [
        Home(data: data, addData : addData),
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

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage}) : super(key: key);
  final userImage;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지 업로드 화면'),
          IconButton(icon: Icon(Icons.close), onPressed: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }

}

