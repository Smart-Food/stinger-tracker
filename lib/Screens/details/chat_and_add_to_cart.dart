import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stinger_tracker/camera/camera_screen.dart';
import 'package:stinger_tracker/csv_operations.dart';
import 'package:csv/csv.dart';
import '../../constants.dart';

class ChatAndAddToCart extends StatelessWidget {
  const ChatAndAddToCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: 18,
          ),
          // SizedBox(width: kDefaultPadding / 2),
          // Text(
          //   "Chat",
          //   style: TextStyle(color: Colors.white),
          // ),
          // it will cover all available spaces
          Spacer(),
          FlatButton.icon(
              onPressed: () {
                // List<List> inspection = [
                //   [users[0].name, users[0].damage[0]]
                // ];
                // String csv = const ListToCsvConverter(textDelimiter: '|').convert(inspection);
                // //print(csv);
                // widget.storage.writeData(csv);
                // widget.storage.readData().then((contents) {
                //   setState(() {
                //     //fileContents = contents;
                //   });
                //   print(contents);
                // });
                // widget.storage.localPath.then((s){print(s);});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              },
            icon: SvgPicture.asset(
              "assets/icons/shopping-bag.svg",
              height: 18,
            ),
            label: Text(
              "Сохранить данные и сделать снимок",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
