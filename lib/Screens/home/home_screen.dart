import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/Screens/loginsignup/sun.dart';
import 'package:stinger_tracker/constants.dart';
import 'package:stinger_tracker/components/search_box.dart';
import 'package:stinger_tracker/fade_animation.dart';
import 'package:stinger_tracker/models/product.dart';
import '../../csv_operations.dart';
import 'product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stinger_tracker/form.dart';
import 'package:stinger_tracker/masterform.dart';
import 'package:stinger_tracker/Screens/details/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:stinger_tracker/singleton.dart';
import 'package:stinger_tracker/navigate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    this.myName,
    this.myIndex,
    this.isDayMood,
    this.isFullSun
  });

  final String myName;
  final int myIndex;
  final bool isDayMood, isFullSun;

  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();

}

class _HomeScreenScreenState extends State<HomeScreen> {

  bool showFlushBar = true;

  Duration _duration = Duration(seconds: 1);

  List categories = ['Задачи', 'Избранное', 'История', 'Настройки'];

  @override
  void initState() {
    super.initState();
    final singleton = Provider.of<Singleton>(context, listen: false);
    singleton.activateSpeechRecognizer(context);
    singleton.start();
  }

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
    return Consumer<Singleton>(
        builder: (context, singleton, child)
    {
      if (singleton.isNavigatingOpen) {
        navigateToOpen();
        singleton.isNavigatingOpen = false;
      }
      if (singleton.isNavigatingCreate) {
        navigateToCreate();
        singleton.isNavigatingCreate = false;
      }
      return Consumer<Navigate>(builder: (context, flushBar, child) {
        return Stack(
          children: [
            Scaffold(
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
                                margin: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 2),
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexHome = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            left: kDefaultPadding,
                                            // At end item it add extra 20 right  padding
                                            right: index == categories.length - 1
                                                ? kDefaultPadding
                                                : 0,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding),
                                          decoration: BoxDecoration(
                                            color: index == singleton.selectedIndexHome
                                                ? Colors.white.withOpacity(0.4)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                6),
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
                                  _body(singleton.selectedIndexHome)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: singleton.Mykhalich ? 1.0 : 0.0,
                  child: SvgPicture.asset("assets/images/businessman.svg")
              ),
            ),
            Positioned(
              left: 40,
              bottom: 40,
              child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: widget.isDayMood
                    ? lightBgColors[1]
                    : darkBgColors[1],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    widget.isDayMood
                        ? DropdownScreen(Storage('list.csv'))
                        : MasterDropdownScreen(Storage('tasks.csv'))),
                  );
                },
              ),
            ),
          ],
        );
      });
    });
  }

  _body(int selectedIndex) {
    switch(selectedIndex) {
      case 0:
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("slaves").doc(widget.myName).collection("tasks").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => FadeAnimation(0 + 0.1 * index,
                      ProductCard(
                        masterName: snapshot.data.documents[index].data()["masterName"],
                        isCheck: snapshot.data.documents[index].data()["isCheck"],
                        address: snapshot.data.documents[index].data()["address"],
                        itemIndex: index,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              masterName: snapshot.data.documents[index].data()["masterName"],
                              isCheck: snapshot.data.documents[index].data()["isCheck"],
                              address: snapshot.data.documents[index].data()["address"],
                              description: snapshot.data.documents[index].data()["description"],
                            ),
                          ),
                        ),
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

  void navigateToOpen() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseFirestore.instance.collection("slaves").doc(widget.myName).collection("tasks").get().then((tasks) {
        if (tasks.docs[0] != null)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                masterName: tasks.docs[0].data()["masterName"],
                isCheck: tasks.docs[0].data()["isCheck"],
                address: tasks.docs[0].data()["address"],
                description: tasks.docs[0].data()["description"],
              ),
            ),
          );
      });
    });
  }

  void navigateToCreate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
        widget.isDayMood
            ? DropdownScreen(Storage('list.csv'))
            : MasterDropdownScreen(Storage('tasks.csv'))),
      );
    });
  }
}