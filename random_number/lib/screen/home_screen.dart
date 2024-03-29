import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number/screen/constant/color.dart';
import 'package:random_number/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  onPressed: onSettingsPop,
                ),
                _Body(randomNumbers: randomNumbers),
                _Footer(onPressed: onRandomNumberGenerate)
              ],
            ),
          ),
        ));
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen();
        },
      ),
    );

    setState(() {
      maxNumber = result;
    });
  }

  void onRandomNumberGenerate() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      newNumbers.add(rand.nextInt(maxNumber));
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
            onPressed: onPressed,
            child: Text('생성하기!')),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: randomNumbers
                .asMap()
                .entries
                .map((e) => Padding(
                      padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16.0),
                      child: Row(
                          children: e.value
                              .toString()
                              .split('')
                              .map((x) => Image.asset(
                                    'asset/img/$x.png',
                                    height: 70.0,
                                    width: 50.0,
                                  ))
                              .toList()),
                    ))
                .toList()));
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30.0),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ))
      ],
    );
  }
}
