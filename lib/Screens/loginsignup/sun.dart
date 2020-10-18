import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sun extends StatelessWidget {
  const Sun({
    Key key,
    @required Duration duration,
    @required this.isFullSun,
  })  : _duration = duration,
        super(key: key);

  final Duration _duration;
  final bool isFullSun;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return AnimatedPositioned(
      duration: _duration,
      curve: Curves.easeInOut,
      left: height * 0.5,
      bottom: isFullSun ? width * 1.15 : - width * 0.2,
      child: SvgPicture.asset("assets/icons/Sun1.svg"),
    );
  }
}
