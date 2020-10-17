import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stinger_tracker/form.dart';
import 'package:stinger_tracker/speech_recognition.dart';
import 'csv_operations.dart';
import 'Screens/loginsignup/loginsignup_screen.dart';
import 'masterform.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MasterDropdownScreen(Storage('list.csv')), //DropdownScreen LoginSignupScreen
    );
  }
}