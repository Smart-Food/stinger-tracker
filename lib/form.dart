import 'package:flutter/material.dart';

class Item {
  const Item(this.name,this.icon, this.damage);
  final String name;
  final Icon icon;
  final List<String> damage;
}
class DropdownScreen extends StatefulWidget {
  State createState() => DropdownScreenState();
}
class DropdownScreenState extends State<DropdownScreen> {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Линейный разъединитель',Icon(Icons.android,color:  const Color(0xFF167F67)),
        ['Поломка рукоятки включения']),
    const Item('Отпаячный разъединитель',Icon(Icons.flag,color:  const Color(0xFF167F67)),
        ['Сломанные ножи разъединителя']),
    const Item('Провод',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67)),
        ['Провис']),
    const Item('Разрядник',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67)),
        ['Перегорел']),
    const Item('Изолятор',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67)),
        ['Трещина']),
  ];
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('a'),),
        body:  Column (
            children: [
            DropdownButton<Item>(
              hint: Text("Select item"),
              value: selectedUser,
              onChanged: (Item value) {
                setState(() {
                  selectedUser = value;
                });
              },
              items: users.map((Item user) {
                return  DropdownMenuItem<Item>(
                  value: user,
                  child: Row(
                    children: <Widget>[
                      user.icon,
                      SizedBox(width: 10),
                      Text(
                        user.name,
                        style:  TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            DropdownButton<Item>(
              hint: Text("Select item"),
              value: selectedUser,
              onChanged: (Item value) {
                setState(() {
                  selectedUser = value;
                });
              },
              items: users.map((Item user) {
                return DropdownMenuItem<Item>(
                  value: user,
                  child: Row(
                    children: <Widget>[
                      user.icon,
                      SizedBox(width: 10),
                      Text(
                        user.damage[0],
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ])
      );
  }
}