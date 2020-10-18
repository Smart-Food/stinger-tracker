
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


///Класс реагирует на действия пользователя и выдает всплывающее сообщение сверхуй
class Navigate extends ChangeNotifier{

  bool isNavigating = false;

  void toNavigate(){

    if (!isNavigating) {
      this.isNavigating = true;

      notifyListeners();
    }


  }

}