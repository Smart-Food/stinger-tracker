import 'package:cloud_firestore/cloud_firestore.dart';

class UserGlobal {
  Future addData(String nameEditingControllerText, passwordEditingControllerText, bool isMaster) async {
    FirebaseFirestore.instance
        .collection(!isMaster ? "slaves":"masters")
        .doc(nameEditingControllerText)
        .set({
      "myName" : nameEditingControllerText,
      "myPassword" : passwordEditingControllerText,
    });
  }
}