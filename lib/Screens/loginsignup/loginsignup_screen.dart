import 'dart:async';

import 'package:stinger_tracker/size_config.dart';
import 'package:flutter/material.dart';

import 'land.dart';
import 'rounded_text_field.dart';
import 'sun.dart';
import 'tabs.dart';
import 'rounded_button.dart';

import 'package:stinger_tracker/fade_animation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stinger_tracker/backend/user_global.dart';
import 'package:stinger_tracker/backend/user_local.dart';

import 'package:stinger_tracker/screens/home/home_screen.dart';

class LoginSignupScreen extends StatefulWidget {

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();

}

class _LoginSignupScreenState extends State<LoginSignupScreen> {

  String nameErrorText = "", passwordErrorText = "";

  Duration _duration = Duration(seconds: 1);

  TextEditingController nameSignupEditingController = TextEditingController(),
      nameLoginEditingController = TextEditingController(),
      passwordSignupEditingController = TextEditingController(),
      passwordLoginEditingController = TextEditingController();

  bool isFullSun = false, isDayMood = true,
      isChangeLoginSignup = false, isSignup = true,
      canLoginSignup = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isFullSun = true;
      });
    });
  }

  void changeMood(int activeTabNum) {
    if (activeTabNum == 0) {
      setState(() {
        isDayMood = true;
      });
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          isFullSun = true;
        });
      });
    } else {
      setState(() {
        isFullSun = false;
      });
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          isDayMood = false;
        });
      });
    }
  }

  void changeLoginSignup() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  void login() {
    FirebaseFirestore.instance.collection("slaves").get().then((drivers) {
      int myIndex = 0;
      for (int index = 0; index < drivers.docs.length; index++) {
        if (nameLoginEditingController.text == drivers.docs[index].data()["myName"] &&
            passwordLoginEditingController.text == drivers.docs[index].data()["myPassword"]) {
          myIndex = index;
          UserLocal.saveUserLoggedInSharedPreference(true);
          UserLocal.saveUserIndexSharedPreference(myIndex);
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(
              myName: drivers.docs[index].data()["myName"],
              myIndex: myIndex
          )
          ));
        }
      }
    });
  }

  void signup() {
    UserGlobal().addData(
        nameSignupEditingController.text,
        passwordSignupEditingController.text
    ).then((value) {
      FirebaseFirestore.instance.collection("slaves").get().then((drivers){
        int myIndex = 0;
        for (int index = 0; index < drivers.docs.length; index++) {
          if (nameSignupEditingController.text == drivers.docs[index].data()["myName"]) {
            print("Да");
            myIndex = index;
            UserLocal.saveUserLoggedInSharedPreference(true);
            UserLocal.saveUserIndexSharedPreference(myIndex);
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(
                myName: nameSignupEditingController.text,
                myIndex: myIndex
            )
            ));
          }
        }
      });
    });
  }

  inputListener() {
    if (isSignup)
      if (nameSignupEditingController.text != ""
          && passwordSignupEditingController.text != "")
        setState(() {
          canLoginSignup = true;
        });
      else
        setState(() {
          canLoginSignup = false;
        });
    else
      if (nameLoginEditingController.text != ""
          && passwordLoginEditingController.text != "")
        setState(() {
          canLoginSignup = true;
        });
      else
        setState(() {
          canLoginSignup = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (isFullSun) Color(0xFFFF9D80),
    ];
    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDayMood ? lightBgColors : darkBgColors,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Sun(duration: _duration, isFullSun: isFullSun),
                      Land(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpacing(of: 50),
                              FadeAnimation(
                                0,
                                Tabs(
                                  press: (value) {
                                    changeMood(value);
                                  },
                                ),
                              ),
                              VerticalSpacing(),
                              FadeAnimation(
                                0.1,
                                Text(
                                  isDayMood
                                      ? "Доброе утро"
                                      : "Добрый вечер",
                                  style: Theme.of(context).textTheme.headline3.copyWith(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              VerticalSpacing(of: 10),
                              FadeAnimation(
                                0.2,
                                Text(
                                  isSignup
                                      ? "Зарегистрируйтесь в нашем приложении"
                                      : "Войдите в свой аккаунт",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              VerticalSpacing(of: 50),
                              FadeAnimation(
                                0.3,
                                RoundedTextField(
                                  hintText: "Имя пользователя",
                                  valueChanged: (value) => inputListener(),
                                  textEditingController: isSignup
                                      ? nameSignupEditingController
                                      : nameLoginEditingController,
                                  isPassword: false,
                                ),
                              ),
                              VerticalSpacing(),
                              FadeAnimation(
                                0.3,
                                RoundedTextField(
                                    hintText: "Пароль",
                                    valueChanged: (value) => inputListener(),
                                    textEditingController: isSignup
                                        ? passwordSignupEditingController
                                        : passwordLoginEditingController,
                                    isPassword: true
                                ),
                              ),
                              VerticalSpacing(of: 10),
                              Center(
                                child: FadeAnimation(
                                  0.4,
                                  Opacity(
                                    opacity: canLoginSignup ? 1.0 : 0.5,
                                    child: RoundedButton(
                                      text: isSignup
                                          ? "ЗАРЕГИСТРИРОВАТЬСЯ"
                                          : "ВОЙТИ",
                                      press: () {
                                        if (canLoginSignup)
                                          if (isSignup)
                                            signup();
                                          else login();
                                      },
                                    ),
                                  )
                                ),
                              ),
                              FadeAnimation(
                                  0.5,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          isSignup
                                              ? "Есть аккаунт?"
                                              : "Нет аккаунта"
                                      ),
                                      GestureDetector(
                                          onTap: () => changeLoginSignup(),
                                          child: Text(
                                              isSignup
                                                  ? " Войдите"
                                                  : " Зарегистрируйтесь",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600, fontSize: 18
                                              )
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}