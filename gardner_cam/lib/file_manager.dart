import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gardner_cam/model/user.dart';
import 'package:gardner_cam/utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory? directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<File> get _file async {
    final path = await _directoryPath;
    return File('$path/cheetah.txt');
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    //print(path);
    return File('$path/user.json');
  }

  Future<File> get _imageFile1 async {
    final path = await _directoryPath;
    return File('$path/1.jpg');
  }

  Future<File> get _imageFile2 async {
    final path = await _directoryPath;
    return File('$path/2.jpg');
  }

  Future<File> get _imageFile3 async {
    final path = await _directoryPath;
    return File('$path/3.jpg');
  }

  Future<File> get _imageFile4 async {
    final path = await _directoryPath;
    return File('$path/4.jpg');
  }

  Future<File> get _imageFile5 async {
    final path = await _directoryPath;
    return File('$path/5.jpg');
  }

  Future<String> readTextFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return fileContent;
  }

  Future<String> writeTextFile() async {
    String text = DateFormat('h:mm:ss').format(DateTime.now());

    File file = await _file;
    await file.writeAsString(text);
    return text;
  }

  Future<Map<String, dynamic>> readJsonFile() async {
    String fileContent = '{}';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    }
    return json.decode(fileContent);
  }

  startUp() async {
    String fileContent = '{}';
    final User user = User(
        'Laboratorium Teknik Sipil', 'Magelang', 'https://elab.untidar.ac.id');

    File file = await _jsonFile;

    if (await file.exists() == false) {
      await file.writeAsString(json.encode(user));
    } else {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }
    lab = await User.fromJson(json.decode(fileContent));
    //  user = User.fromJson(json.decode(fileContent));
    // return json.decode(fileContent);
    //return user;
  }

  Future<User> writeUserFile(String name, String address, String web) async {
    final User user = User(name, address, web);
    String jsonString = '{"name":"$name","address":"$address","web":"$web"}';
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    String backTojsonMap = jsonEncode(jsonMap);

    File file = await _jsonFile;
    await file.writeAsString(backTojsonMap);
    return user;
  }

  Future<User> writeJsonFile() async {
    final User user = User(
        'Laboratorium Teknik Sipil', 'Magelang', 'https://elab.untidar.ac.id');

    File file = await _jsonFile;
    await file.writeAsString(json.encode(user));
    return user;
  }

  //Future<Uint8List> writeImageFile(File image, int stdNo) async {
  // Response response = await Client().get(
  //   Uri.parse(
  //       'https://i.pinimg.com/originals/f5/1d/08/f51d08be05919290355ac004cdd5c2d6.png'),
  // );

  //Uint8List bytes = response.bodyBytes;
  //File file = await _imageFile;
  //await file.writeAsBytes(bytes);

  //print(file.path);
  //print(bytes);

  //return bytes;
  //}

  Future<Uint8List> writeImageFile(Uint8List image, int std) async {
    File file = await _imageFile1;
    switch (std) {
      case 1:
        file = await _imageFile1;
        break;
      case 2:
        file = await _imageFile2;
        break;
      case 3:
        file = await _imageFile3;
        break;
      case 4:
        file = await _imageFile4;
        break;
      case 5:
        file = await _imageFile5;
        break;
    }
    // Uint8List? byteList = await file.readAsBytes();
    await file.writeAsBytes(image);

    print(file.path);
    // print(byteList);
    return image;
  }

  Future<Uint8List> readImageFile(int std) async {
    //File file = await _imageFile;
    File file = await _imageFile1;
    switch (std) {
      case 1:
        file = await _imageFile1;
        break;
      case 2:
        file = await _imageFile2;
        break;
      case 3:
        file = await _imageFile3;
        break;
      case 4:
        file = await _imageFile4;
        break;
      case 5:
        file = await _imageFile5;
        break;
    }

    Uint8List? byteList;

    if (await file.exists()) {
      try {
        byteList = await file.readAsBytes();
      } catch (e) {
        print(e);
      }
    }

    return byteList!;
  }

  cekImageFile() async {
    File file1 = await _imageFile1;
    File file2 = await _imageFile2;
    File file3 = await _imageFile3;
    File file4 = await _imageFile4;
    File file5 = await _imageFile5;
    if (await file1.exists() == false) {
      ByteData data = await rootBundle.load('assets/images/1.jpg');
      Uint8List byteList = data.buffer.asUint8List();
      await file1.writeAsBytes(byteList);
    }
    if (await file2.exists() == false) {
      ByteData data = await rootBundle.load('assets/images/2.jpg');
      Uint8List byteList = data.buffer.asUint8List();
      await file2.writeAsBytes(byteList);
    }
    if (await file3.exists() == false) {
      ByteData data = await rootBundle.load('assets/images/3.jpg');
      Uint8List byteList = data.buffer.asUint8List();
      await file3.writeAsBytes(byteList);
    }
    if (await file4.exists() == false) {
      ByteData data = await rootBundle.load('assets/images/4.jpg');
      Uint8List byteList = data.buffer.asUint8List();
      await file4.writeAsBytes(byteList);
    }
    if (await file5.exists() == false) {
      ByteData data = await rootBundle.load('assets/images/5.jpg');
      Uint8List byteList = data.buffer.asUint8List();
      await file5.writeAsBytes(byteList);
    }
    // stdIm1 = file1.path;
    // stdIm2 = file2.path;
    // stdIm3 = file3.path;
    // stdIm4 = file4.path;
    // stdIm5 = file5.path;
  }

  // deleteImage() async {
  //   File file = await _imageFile;
  //   if (await file.exists()) {
  //     await file.delete();
  //   }
  // }
}
