import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class Storage {
  String fileName;
  Storage(this.fileName);
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<String> readData() async {
    try {
      final File file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}
//Button

/*onPressed: (){
            List<List> inspection = [
              [selectedUser.name, selectedUser.damage[0]]
            ];
            String csv = const ListToCsvConverter(textDelimiter: '|').convert(inspection);
            //print(csv);
            widget.storage.writeData(csv);
            widget.storage.readData().then((contents) {
              setState(() {
                fileContents = contents;
              });
              print(contents);
            });
            widget.storage.localPath.then((s){print(s);});
          },*/
/*
class DropdownScreen extends StatefulWidget {
  final Storage storage;
  DropdownScreen(this.storage) : super();
  State createState() => DropdownScreenState();
}
* */