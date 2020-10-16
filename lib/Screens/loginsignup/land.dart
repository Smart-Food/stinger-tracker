import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../size_config.dart';

class Land extends StatelessWidget {
  const Land({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
          "assets/images/loginsignup.svg",
          alignment: Alignment.bottomCenter
      ),
    );
  }
}
