import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:stinger_tracker/Screens/home/home_screen.dart';
import 'package:stinger_tracker/form.dart';
import 'package:stinger_tracker/csv_operations.dart';
class PreviewScreen extends StatefulWidget{
  final String imgPath;
  final String address;

  PreviewScreen({this.imgPath, this.address});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();

}
class _PreviewScreenState extends State<PreviewScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.file(File(widget.imgPath),fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.black,
                child: GestureDetector(
                  onTap: () => uploadTask(widget.address, true, 'Палыч'),
                  child: Center(
                  child: IconButton(
                    icon: Icon(Icons.share,color: Colors.white,),
                    onPressed: (){
                      getBytesFromFile().then((bytes){
                        Share.file('Поделиться', basename(widget.imgPath), bytes.buffer.asUint8List(),'image/path');//.then((context) => null)
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                      });
                    },
                  ),
                ),)
              ),
            )
          ],
        ),
      ),
    );
  }
  uploadTask(String address, bool isCheck, String masterName) async {
    FirebaseFirestore.instance
        .collection('slaves').doc('Dyk').collection('tasks').add({
      'address': address,
      'isCheck': isCheck,
      'masterName': masterName,
    }) as CollectionReference;
  }

  Future<ByteData> getBytesFromFile() async{
    Uint8List bytes = File(widget.imgPath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}