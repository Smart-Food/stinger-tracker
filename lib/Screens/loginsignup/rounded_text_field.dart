import 'package:flutter/material.dart';

import '../../size_config.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key key,
    this.textEditingController,
    this.valueChanged,
    this.hintText,
    this.isPassword,
  }) : super(key: key);

  final String hintText;
  final ValueChanged valueChanged;
  final TextEditingController textEditingController;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
              color: Colors.white60,
          fontSize: 18),
        ),
        VerticalSpacing(of: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          child: TextField(
            onChanged: valueChanged,
            style: TextStyle(color: Colors.white),
            controller: textEditingController,
            obscureText: isPassword,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
