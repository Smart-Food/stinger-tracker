import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:stinger_tracker/csv_operations.dart';

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
  @override
  Widget build(BuildContext context) {

    String _inputErrorText;
    final TextEditingController _heading =  TextEditingController();
    final TextEditingController _topic =  TextEditingController();
    final TextEditingController _description =  TextEditingController();
    final TextEditingController _area =  TextEditingController();

    // final objects = [
    //   'a', 'b', 'c'
    // ];
    // final teams = [
    //   'a', 'b', 'c'
    // ];
    // final places = [
    //   'a', 'b', 'c'
    // ];

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(right: 300, bottom: 80),
                  child: Text(
                    'Заявка',
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w300
                    ),
                  ))
              ,
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      labelText: "Команда",
                      errorText: _inputErrorText,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )
                  ),
                  textInputAction: TextInputAction.done,
                  controller: _heading,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      labelText: "Район",
                      errorText: _inputErrorText,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )
                  ),
                  controller: _area,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      labelText: "Объект",
                      errorText: _inputErrorText,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              color: kSecondaryColor
                          )
                      )
                  ),
                  controller: _topic,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Описание",
                      errorText: _inputErrorText,
                      fillColor: Colors.white,
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              color: kSecondaryColor
                          )
                      )
                  ),
                  controller: _description,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 7.8 * 3,
                    backgroundColor: Color(0xFF8C2480),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 7.8 * 3,
                    backgroundColor: Color(0xFFCE587D),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.assessment),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 7.8 * 3,
                    backgroundColor: Color(0xFFFF9485),
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.white, onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: FlatButton(
                        minWidth: 300,
                        onPressed: () => uploadTask(_area.text, false, 'Палыч'),
                        color: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Center(
                          child: Text("Создать",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                        ),))
                ],
              ),
            ]
        )
    );

  }
  uploadTask(String address, bool isCheck, String masterName) async {
    FirebaseFirestore.instance
        .collection('slaves').doc('Dyk').collection('tasks').add({
      'address': address,
      'isCheck': isCheck,
      'masterName': masterName
    }) as CollectionReference;
  }
}