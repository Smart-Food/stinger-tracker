import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/constants.dart';
import 'package:stinger_tracker/components/search_box.dart';
import 'package:stinger_tracker/fade_animation.dart';
import 'package:stinger_tracker/models/product.dart';
import 'product_card.dart';
import 'package:stinger_tracker/screens/loginsignup/sun.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    this.myName,
    this.myIndex,
    this.isDayMood, this.isFullSun
  }) : super(key: key);

  final String myName;
  final int myIndex;
  final bool isDayMood, isFullSun;

  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();

}

class _HomeScreenScreenState extends State<HomeScreen> {

  Duration _duration = Duration(seconds: 1);

  int selectedIndex = 0;
  List categories = ['Все', 'Избранное', 'История', 'Настройки', ];

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (widget.isFullSun) Color(0xFFFF9D80),
    ];
    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.isDayMood ? lightBgColors : darkBgColors,
              ),
            ),
            child: Stack(
              children: [
                Sun(duration: _duration, isFullSun: widget.isFullSun),
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        0.0,
                        Text(
                            'Добро пожаловать, ${widget.myName}',
                            style: TextStyle(
                                color: Colors.white
                            )
                        ),
                      ),
                      SearchBox(onChanged: (value) {}),
                      FadeAnimation(
                        0.2,
                        Container(
                          margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: kDefaultPadding,
                                  // At end item it add extra 20 right  padding
                                  right: index == categories.length - 1 ? kDefaultPadding : 0,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                decoration: BoxDecoration(
                                  color: index == selectedIndex
                                      ? Colors.white.withOpacity(0.4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 70),
                              decoration: BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                            ),
                            _body(selectedIndex)
                          ],
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

  _body(int selectedIndex) {
    switch(selectedIndex) {
      case 0:
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("slaves").doc(widget.myName).collection("tasks").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Загружаем...");
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => FadeAnimation(0 + 0.1 * index,
                  ProductCard(
                    masterName: snapshot.data.documents[index].data()["masterName"],
                    isCheck: snapshot.data.documents[index].data()["isCheck"],
                    address: snapshot.data.documents[index].data()["address"],
                    itemIndex: index,
                  )
                )
              );
            }
        );
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container();
        break;
      default:
        return;
    }
  }
}