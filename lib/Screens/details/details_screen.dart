import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/constants.dart';
import 'package:stinger_tracker/models/product.dart';
import 'list_of_colors.dart';
import 'product_image.dart';
import 'body.dart';
import 'chat_and_add_to_cart.dart';

class DetailsScreen extends StatefulWidget {

  DetailsScreen({
    this.masterName,
    this.isCheck,
    this.address,
    this.isFavorite
  });

  final String masterName, address;
  final bool isCheck, isFavorite;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    Center(
                      child: Hero(
                        tag: widget.address,
                        child: ProductPoster(
                          size: size,
                          image: widget.isCheck ? "assets/images/check.svg" : "assets/images/notCheck.svg",
                        ),
                      ),
                    ),
                    ListOfColors(),
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
}
