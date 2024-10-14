import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gardner_cam/model/user.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}

User? lab;
String stdIm1 = '';
String stdIm2 = '';
String stdIm3 = '';
String stdIm4 = '';
String stdIm5 = '';

Future<User> readJsonConfig() async {
  final jsonData = await rootBundle.loadString('assets/config.json');
  Map<String, dynamic> jsonMap = jsonDecode(jsonData);
  //final lab = Laboratorium.fromJson(jsonMap);
  return User.fromJson(jsonMap);
}

void writeJsonConfig(String name, String address, String web) {
  String jsonString = '{"name":"$name","address":"$address","web":"$web"}';
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  String backTojsonMap = jsonEncode(jsonMap);
  print(backTojsonMap);
}

void UpdateFromJson() {
  readJsonConfig().then((value) {
    lab = value;
  });
}
