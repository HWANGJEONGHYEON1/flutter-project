import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      setState(() {
        name = contacts;
      });

    } else if (status.isDenied) {
      print('거절됨');
      // Permission.contacts.request();
      // openAppSettings();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  int total = 3;
  List<Contact> name = [];
  var likeArr = [0, 0, 0];

  void addTotal() {
    setState(() {
      total = total + 2;
    });
  }

  addFriend(String value) {
    setState(() {
      var newPerson = new Contact();
      newPerson.givenName = value;
      ContactsService.addContact(newPerson);
      name.add(newPerson);
    });
  }

  removeFriend(String removeName, int index) {
    setState(() {
      // name.remove(index);
      // likeArr.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return DialogUi(likeArr: likeArr, addOne: addTotal, addFriend: addFriend);
            });
          },
        ),
        appBar: AppBar( title: Text(total.toString()), actions: [
          IconButton(onPressed: () {
            getPermission();
          }, icon: Icon(Icons.contacts))
        ],),
        body: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, i){
              return
                ListTile(
                    leading: Text(name[i].familyName ?? '이름없음'),
                    title: Text(name[i].givenName.toString()),
                    trailing: ElevatedButton(
                      child: Text('삭제'),
                      onPressed: () {
                        setState(() {
                          // removeFriend(name[i].givenName, i);
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
  var addFriend;

  DialogUi({this.likeArr, this.addOne, this.addFriend, Key? key}) : super(key: key);

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
                addFriend(inputData.text);
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
