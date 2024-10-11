import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/model/laboratorium.dart';
import 'package:gardner_cam/pages/main_page.dart';
import 'package:gardner_cam/utils.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   lab = ReadJsonConfig();
    //print(ReadJsonConfig());
    return const ScreenUtilInit(
      designSize: Size(1440, 2560),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
  Future<Laboratorium>ReadJsonConfig() async{
      final jsonData = await rootBundle.loadString('assets/config.json');
      Map<String,dynamic> jsonMap = jsonDecode(jsonData);
      //final lab = Laboratorium.fromJson(jsonMap);
      return Laboratorium.fromJson(jsonMap);
    }
}
