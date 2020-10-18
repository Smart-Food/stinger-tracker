import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/constants.dart';
import 'product_image.dart';
import 'chat_and_add_to_cart.dart';
import 'package:stinger_tracker/fade_animation.dart';
import 'color_dots.dart';

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

  int selectedIndex = 0;

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
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(context),
        body: SafeArea(
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
                      _body(selectedIndex),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              child: ColorDot(
                                fillColor: Color(0xFF80989A),
                                isSelected: selectedIndex == 0 ? true : false,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: ColorDot(
                                fillColor: Color(0xFFFF5200),
                                isSelected: selectedIndex == 1 ? true : false,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 2;
                                });
                              },
                              child: ColorDot(
                                fillColor: kPrimaryColor,
                                isSelected: selectedIndex == 2 ? true : false,
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
                ChatAndAddToCart(),
              ],
            ),
          ),
        )
    );
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
            FadeAnimation(0.4, Text(widget.description))
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