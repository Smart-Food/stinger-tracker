import 'package:cloud_firestore/cloud_firestore.dart';

class UserGlobal {
  Future addData(String nameEditingControllerText, passwordEditingControllerText) async {
    FirebaseFirestore.instance
        .collection("slaves")
        .doc(nameEditingControllerText)
        .set({
      "myName" : nameEditingControllerText,
      "myPassword" : passwordEditingControllerText,
    });
  }
}