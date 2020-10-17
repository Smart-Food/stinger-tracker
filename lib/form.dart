import 'dart:io';

import 'package:flutter/material.dart';
import 'camera/camera_screen.dart';
import 'constants.dart';
import 'fade_animation.dart';
import 'package:stinger_tracker/csv_operations.dart';
import 'package:csv/csv.dart';
class Item {
  String name;
  String object;
  DateTime startDate, endDate;
  Icon icon;
  List<String> damage;
  int isSelected = 0;
  Item({this.name,this.icon, this.damage, this.object, this.startDate, this.endDate, this.isSelected});
}



class DropdownScreen extends StatefulWidget {
  final Storage storage;
  DropdownScreen(this.storage) : super();
  State createState() => DropdownScreenState();
}

class DropdownScreenState extends State<DropdownScreen> {
  File imageFile;
  List<Item> users = <Item>[
    Item(name: 'Линейный разъединитель', damage: ['Поломка рукоятки включения']),
    Item(name: 'Отпаячный разъединитель', damage: ['Сломанные ножи разъединителя']),
    Item(name: 'Провод', damage: ['Провис']),
    Item(name: 'Разрядник', damage: ['Перегорел']),
    Item(name: 'Изолятор', damage: ['Трещина']),
  ];
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    Size size = MediaQuery.of(context).size;

      return Scaffold(
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: [
            ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => FadeAnimation(0 + 0.1 * index,
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2,
                      ),
                      // color: Colors.blueAccent,
                      height: 160,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (users[index].isSelected == 0)
                              users[index].isSelected = 1;
                            else
                              users[index].isSelected = 0;
                          });
                          // pageController.animateToPage(1,
                          //     duration: Duration(milliseconds: 250),
                          //     curve: Curves.bounceOut);
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            // Those are our background
                            Container(
                              height: 136,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: users[index].isSelected == 1 ? kBlueColor : kSecondaryColor,
                                boxShadow: [kDefaultShadow],
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                            // our product image
                            // Product title and price
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: SizedBox(
                                height: 136,
                                // our image take 200 width, thats why we set out total width - 200
                                width: size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: Text(
                                          users[index].name,
                                        style: TextStyle(
                                          fontSize: 17
                                        ),
                                        //style: Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                    // it use the available space
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding * 1.5, // 30 padding
                                        vertical: kDefaultPadding / 4, // 5 top and bottom
                                      ),
                                      decoration: BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(22),
                                          topRight: Radius.circular(22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
          ),
            ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => FadeAnimation(0 + 0.1 * index,
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2,
                      ),
                      // color: Colors.blueAccent,
                      height: 160,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (users[index].isSelected == 0)
                              users[index].isSelected = 1;
                            else
                              users[index].isSelected = 0;
                          });
                          // pageController.animateToPage(1,
                          //     duration: Duration(milliseconds: 250),
                          //     curve: Curves.bounceOut);
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            // Those are our background
                            Container(
                              height: 136,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: users[index].isSelected == 1 ? kBlueColor : kSecondaryColor,
                                boxShadow: [kDefaultShadow],
                              ),
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                            // our product image
                            // Product title and price
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: SizedBox(
                                height: 136,
                                // our image take 200 width, thats why we set out total width - 200
                                width: size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: Text(
                                        users[index].damage[0],
                                        style: TextStyle(
                                            fontSize: 17
                                        ),
                                      ),
                                    ),
                                    // it use the available space
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding * 1.5, // 30 padding
                                        vertical: kDefaultPadding / 4, // 5 top and bottom
                                      ),
                                      decoration: BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(22),
                                          topRight: Radius.circular(22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
            ),
            FlatButton(
                child: Text('Сохранить данные и сделать снимок'),
                onPressed: () {
                  List<List> inspection = [
                    [users[0].name, users[0].damage[0]]
                  ];
                  String csv = const ListToCsvConverter(textDelimiter: '|').convert(inspection);
                  //print(csv);
                  widget.storage.writeData(csv);
                  widget.storage.readData().then((contents) {
                    print(contents);
                  });
                  widget.storage.localPath.then((s){print(s);});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  );
                })
          ],
        )

      );
  }
}