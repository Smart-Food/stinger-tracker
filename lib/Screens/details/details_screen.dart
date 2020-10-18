import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/constants.dart';
import 'product_image.dart';
import 'chat_and_add_to_cart.dart';
import 'package:stinger_tracker/fade_animation.dart';
import 'color_dots.dart';
import 'package:provider/provider.dart';
import 'package:stinger_tracker/singleton.dart';
import 'package:stinger_tracker/camera/camera_screen.dart';

class Item {
  String name;
  String object;
  DateTime startDate, endDate;
  Icon icon;
  List<String> damage;
  int isSelected;
  Item({this.name,this.icon, this.damage, this.object, this.startDate, this.endDate, this.isSelected});
}

class DetailsScreen extends StatefulWidget {

  DetailsScreen({
    this.masterName,
    this.isCheck,
    this.address,
    this.isFavorite,
    this.description
  });

  final String masterName, address, description;
  final bool isCheck, isFavorite;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen> {

  List<Item> damages = <Item>[
    Item(damage: ['Поломка рукоятки включения']),
    Item(damage: ['Сломанные ножи разъединителя']),
  ];

  List<Item> users = <Item>[
    Item(name: 'Линейный разъединитель', damage: ['Поломка рукоятки включения']),
    Item(name: 'Отпаячный разъединитель', damage: ['Сломанные ножи разъединителя']),
    Item(name: 'Провод', damage: ['Провис']),
    // Item(name: 'Разрядник', damage: ['Перегорел']),
    // Item(name: 'Изолятор', damage: ['Трещина']),
  ];



  @override
  void initState() {
    super.initState();
    setState(() {
      for (var item in users) {
        item.isSelected = 0;
        for (var item in damages) {
          item.isSelected = 0;
        }
      }});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Singleton>(builder: (context, singleton, child) {
      if (singleton.isPop) {
        detailsPop();
        singleton.isPop = false;
      }
      if (singleton.isNavigatingToCamera) {
        navigateToCamera();
        singleton.isNavigatingToCamera = false;
      }
      return Stack(
          children: [
            Scaffold(
                backgroundColor: kPrimaryColor,
                appBar: buildAppBar(context),
                body: PageView(
                  controller: singleton.pageController,
                    children: [
                  SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _body(singleton.selectedIndexDetails = 0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.pageController.jumpToPage(0);
                                            singleton.selectedIndexDetails = 0;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFF80989A),
                                          isSelected: singleton.selectedIndexDetails == 0 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.pageController.jumpToPage(1);
                                            singleton.selectedIndexDetails = 1;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFFFF5200),
                                          isSelected: singleton.selectedIndexDetails == 1 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.pageController.jumpToPage(2);
                                            singleton.selectedIndexDetails = 2;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: kPrimaryColor,
                                          isSelected: singleton.selectedIndexDetails == 2 ? true : false,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.title,
                                  //   style: Theme.of(context).textTheme.headline6,
                                  // ),
                                ),
                                Text(
                                  widget.masterName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.description,
                                  //   style: TextStyle(color: kTextLightColor),
                                  // ),
                                ),
                                SizedBox(height: kDefaultPadding),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(kDefaultPadding),
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFCBF1E),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(children: [
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/chat.svg",
                                      height: 18,
                                    ),
                                    Spacer(),
                                    FlatButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute  (builder: (context) => CameraScreen())
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/shopping-bag.svg",
                                        height: 18,
                                      ),
                                      label: Text(
                                        "Прикрепить фото",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],)
                          )
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _body(singleton.selectedIndexDetails = 1),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 0;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFF80989A),
                                          isSelected: singleton.selectedIndexDetails == 0 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 1;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFFFF5200),
                                          isSelected: singleton.selectedIndexDetails == 1 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 2;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: kPrimaryColor,
                                          isSelected: singleton.selectedIndexDetails == 2 ? true : false,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.title,
                                  //   style: Theme.of(context).textTheme.headline6,
                                  // ),
                                ),
                                Text(
                                  widget.masterName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.description,
                                  //   style: TextStyle(color: kTextLightColor),
                                  // ),
                                ),
                                SizedBox(height: kDefaultPadding),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(kDefaultPadding),
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFCBF1E),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(children: [
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/chat.svg",
                                      height: 18,
                                    ),
                                    Spacer(),
                                    FlatButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute  (builder: (context) => CameraScreen())
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/shopping-bag.svg",
                                        height: 18,
                                      ),
                                      label: Text(
                                        "Прикрепить фото",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],)
                          )
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _body(singleton.selectedIndexDetails = 2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 0;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFF80989A),
                                          isSelected: singleton.selectedIndexDetails == 0 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 1;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: Color(0xFFFF5200),
                                          isSelected: singleton.selectedIndexDetails == 1 ? true : false,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleton.selectedIndexDetails = 2;
                                          });
                                        },
                                        child: ColorDot(
                                          fillColor: kPrimaryColor,
                                          isSelected: singleton.selectedIndexDetails == 2 ? true : false,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.title,
                                  //   style: Theme.of(context).textTheme.headline6,
                                  // ),
                                ),
                                Text(
                                  widget.masterName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                                  // child: Text(
                                  //   product.description,
                                  //   style: TextStyle(color: kTextLightColor),
                                  // ),
                                ),
                                SizedBox(height: kDefaultPadding),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(kDefaultPadding),
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFCBF1E),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(children: [
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/chat.svg",
                                      height: 18,
                                    ),
                                    Spacer(),
                                    FlatButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute  (builder: (context) => CameraScreen())
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/shopping-bag.svg",
                                        height: 18,
                                      ),
                                      label: Text(
                                        "Прикрепить фото",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],)
                          )
                        ],
                      ),
                    ),
                  ),
                ])
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
          ]
      );
    });
  }

  void detailsPop() {
//    Color color = Color(0xFF303030);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
    });
  }

  void navigateToCamera() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.push(
          context,
          MaterialPageRoute  (builder: (context) => CameraScreen())
      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Назад'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  _body(int selectedIndex) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    switch (selectedIndex) {
      case 0:
        return Column(
          children: [
            FadeAnimation(0.2,
                Center(
                  child: Hero(
                    tag: widget.address,
                    child: ProductPoster(
                      size: size,
                      image: widget.isCheck ? "assets/images/check.svg" : "assets/images/notCheck.svg",
                    ),
                  ),
                )
            ),
            FadeAnimation(0.4, Text(widget.description)),
            FadeAnimation(0.4, Text('${now.day}.${now.month} ${now.hour}:${now.minute}')),
          ],
        );
        break;
      case 1:
        return Column(
            children: [
              for (int index = 0; index < users.length; index++)
                FadeAnimation(0 + 0.1 * index,
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
                            print(users[index].isSelected);
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
                                        color: kPrimaryColor,
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
            ]
        );
        break;
      case 2:
        return Column(
          children: [
            for (int index = 0; index < damages.length; index++)
              FadeAnimation(0 + 0.1 * index, Container(
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                // color: Colors.blueAccent,
                height: 160,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (damages[index].isSelected == 0)
                        damages[index].isSelected = 1;
                      else
                        damages[index].isSelected = 0;
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
                          color: damages[index].isSelected == 1 ? kSecondaryColor : kBlueColor,
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
                                  damages[index].damage[0],
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
              ))
          ],
        );
        break;
      default:
        return;
    }
  }
}