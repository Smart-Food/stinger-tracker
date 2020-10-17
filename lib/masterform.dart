import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stinger_tracker/Screens/home/home_screen.dart';
import 'camera/camera_screen.dart';
import 'constants.dart';
import 'fade_animation.dart';
import 'package:stinger_tracker/csv_operations.dart';
import 'package:csv/csv.dart';
import 'dart:async';

class Item {
  String name;
  String object;
  DateTime startDate, endDate;
  Icon icon;
  List<String> worker;
  int isSelected = 0;
  Item({this.name,this.icon, this.worker, this.object, this.startDate, this.endDate, this.isSelected});
}



class MasterDropdownScreen extends StatefulWidget {
  Storage storage = Storage('tasks.csv');
  MasterDropdownScreen(this.storage) : super();
  State createState() => MasterDropdownScreenState();
}

class MasterDropdownScreenState extends State<MasterDropdownScreen> {
  File imageFile;
  List<Item> users = <Item>[
    Item(name: 'ВЛ 10 кВ ТП №265- ТП № 240', worker: ['Алексей Сенников']),
    Item(name: 'ВЛ 13 кВ ТП №228- ТП № 210', worker: ['Дык Фам Минь']),
    Item(name: 'ВЛ 33 кВ ТП №520- ТП № 510', worker: ['Павел Ивин']),
    Item(name: 'ВЛ 5 кВ ТП №80- ТП № 65', worker: ['Евгений Жданов']),
    Item(name: 'ВЛ 23 кВ ТП №144- ТП № 130', worker: ['Вениамин  Манукян']),
  ];
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    Size size = MediaQuery.of(context).size;
    

      return Scaffold(
        // appBar: AppBar(
        //   title: Text('Обход'),),
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
                                  color: Colors.lime[50],
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
                                        style: Theme.of(context).textTheme.button,
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
                                        users[index].worker[0],
                                        style: Theme.of(context).textTheme.button,
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
              child: Text('Сохранить данные и перейти на главный экран'),
                onPressed: () {
                  List<List> task = [
                    [users[0].name, users[0].worker[0]]
                  ];
                  String csv = const ListToCsvConverter(textDelimiter: '|').convert(task);
                  //print(csv);
                  widget.storage.writeData(csv);                
                  //widget.storage.localPath.then((s){print(s);});
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            })
          ],
        )

      );
  }
}
