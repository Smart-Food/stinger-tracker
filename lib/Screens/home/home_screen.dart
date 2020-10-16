import 'dart:async';

import 'package:stinger_tracker/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final String myName;
  final int myIndex;
  const HomeScreen({
    Key key,
    this.myName,
    this.myIndex,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ты зарегистрировался! Ну ахуеть теперь")
      )
    );
  }
}