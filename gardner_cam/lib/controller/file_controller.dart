import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gardner_cam/file_manager.dart';
import 'package:gardner_cam/model/user.dart';

class FileController extends ChangeNotifier {
  String _text = '';
  User? _user;
  Uint8List? _imageByteList;

  Uint8List? _imageByteList1;
  Uint8List? _imageByteList2;
  Uint8List? _imageByteList3;
  Uint8List? _imageByteList4;
  Uint8List? _imageByteList5;

  String get text => _text;
  User? get user => _user;
  Uint8List? get imageByteList => _imageByteList;
  Uint8List? get imageByteList1 => _imageByteList1;
  Uint8List? get imageByteList2 => _imageByteList2;
  Uint8List? get imageByteList3 => _imageByteList3;
  Uint8List? get imageByteList4 => _imageByteList4;
  Uint8List? get imageByteList5 => _imageByteList5;

  readText() async {
    _text = await FileManager().readTextFile();
    notifyListeners();
  }

  writeText() async {
    _text = await FileManager().writeTextFile();
    notifyListeners();
  }

  readUser() async {
    final result = await FileManager().readJsonFile();

    if (result != null) {
      _user = User.fromJson(await FileManager().readJsonFile());
    }
    // print(_user.toString());
    notifyListeners();
  }

  writeUser() async {
    _user = await FileManager().writeJsonFile();
    //print(_user.toString());
    notifyListeners();
  }

  readImage(int stdNo) async {
    _imageByteList = await FileManager().readImageFile(stdNo);
    switch (stdNo) {
      case 1:
        _imageByteList1 = _imageByteList;
        break;
      case 2:
        _imageByteList2 = _imageByteList;
        break;
      case 3:
        _imageByteList3 = _imageByteList;
        break;
      case 4:
        _imageByteList4 = _imageByteList;
        break;
      case 5:
        _imageByteList5 = _imageByteList;
        break;
    }
    //_imageByteList = await FileManager().readImageFile(stdNo);
    notifyListeners();
  }

  writeImage(Uint8List image, int stdNo) async {
    _imageByteList = await FileManager().writeImageFile(image, stdNo);
    switch (stdNo) {
      case 1:
        _imageByteList1 = _imageByteList;
        break;
      case 2:
        _imageByteList2 = _imageByteList;
        break;
      case 3:
        _imageByteList3 = _imageByteList;
        break;
      case 4:
        _imageByteList4 = _imageByteList;
        break;
      case 5:
        _imageByteList5 = _imageByteList;
        break;
    }
    notifyListeners();
  }

/*
  readImage(int stdNo) async {
    _imageByteList = await FileManager().readImageFile(stdNo);
    notifyListeners();
  }

  writeImage(Uint8List image, int stdNo) async {
    _imageByteList = await FileManager().writeImageFile(image, stdNo);
    notifyListeners();
  }
  */

  Future<void> cekImageFile() async {
    FileManager().cekImageFile();
    notifyListeners();
  }

  // deleteImage() async {
  //   FileManager().deleteImage();
  //   _imageByteList = null;
  //   notifyListeners();
  //}
}
