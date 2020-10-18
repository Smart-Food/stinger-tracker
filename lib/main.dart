import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stinger_tracker/form.dart';
import 'package:stinger_tracker/speech_recognition.dart';
import 'csv_operations.dart';
import 'Screens/loginsignup/loginsignup_screen.dart';
import 'masterform.dart';
import 'package:provider/provider.dart';
import 'package:stinger_tracker/singleton.dart';

import 'package:stinger_tracker/navigate.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Singleton>(create: (context) => Singleton()),
        ChangeNotifierProvider<Navigate>(create: (context) => Navigate()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginSignupScreen(),//MasterDropdownScreen(Storage('list.csv')), //DropdownScreen LoginSignupScreen
      ),
    );
  }
}

