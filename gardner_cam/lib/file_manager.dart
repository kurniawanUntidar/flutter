import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gardner_cam/model/user.dart';
import 'package:gardner_cam/utils.dart';
import 'package:http/http.dart';
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
    print(path);
    return File('$path/user.json');
  }

  Future<File> get _imageFile async {
    final path = await _directoryPath;
    return File('$path/cheetah_image');
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
    // return json.decode(fileContent);
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

  Future<Uint8List> writeImageFile() async {
    Response response = await Client().get(
      Uri.parse(
          'https://i.pinimg.com/originals/f5/1d/08/f51d08be05919290355ac004cdd5c2d6.png'),
    );

    Uint8List bytes = response.bodyBytes;
    File file = await _imageFile;
    await file.writeAsBytes(bytes);

    print(file.path);
    print(bytes);

    return bytes;
  }

  Future<Uint8List> readImageFile() async {
    File file = await _imageFile;
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

  deleteImage() async {
    File file = await _imageFile;
    if (await file.exists()) {
      await file.delete();
    }
  }
}