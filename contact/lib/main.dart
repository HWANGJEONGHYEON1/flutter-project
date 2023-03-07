import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home:
        MyApp()
    ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var total = 3;
  var name = ['홍길동', '황뽀롱', '황뽀이'];
  var likeArr = [0, 0, 0];

  void addTotal() {
    setState(() {
      total = total + 2;
    });
  }

  addFriend(String value) {
    setState(() {
      name.add(value);
      likeArr.add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return DialogUi(likeArr: likeArr, addOne: addTotal, addName: addFriend);
            });
          },
        ),
        appBar: AppBar( title: Text(total.toString()),),
        body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, i){
              return
                ListTile(
                    leading: Text(likeArr[i].toString()),
                    title: Text(name[i]),
                    trailing: ElevatedButton(
                      child: Text('좋아요'),
                      onPressed: () {
                        setState(() {
                          likeArr[i]++;
                        });
                      },
                    ),
              );
            }),
        bottomNavigationBar: BottomAppBar(),
      );
  }
}

class DialogUi extends StatelessWidget {
  final likeArr;
  final addOne;
  var inputData = TextEditingController();
  var addName;

  DialogUi({this.likeArr, this.addOne, this.addName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contact'),
      content: TextField(controller: inputData,),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('cancel')
        ),
        TextButton(
            onPressed: () {
              addOne();
              if (inputData.text.isNotEmpty) {
                addName(inputData.text);
              }
              Navigator.pop(context, 'OK');
            },
            child: Text('ok')
        ),
      ],
    );
  }
}


class BottomAppBar extends StatelessWidget {
  const BottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.call),
          Icon(Icons.message),
          Icon(Icons.copy_all_rounded),
        ],
      ),
    ));
  }
}
