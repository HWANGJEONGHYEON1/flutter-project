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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      body: TextButton(onPressed: (){}, child: Text('안녕'),)
    );
  }
}

