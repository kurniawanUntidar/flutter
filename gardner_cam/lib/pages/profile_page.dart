import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/model/laboratorium.dart';
import 'package:gardner_cam/pages/main_page.dart';
import 'package:gardner_cam/utils.dart';

class ProfilePage extends StatefulWidget {
  final Future<Laboratorium>? labProfile;
  const ProfilePage({super.key, required this.labProfile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
Future<Laboratorium>ReadJsonConfig() async{
      final jsonData = await rootBundle.loadString('assets/config.json');
      Map<String,dynamic> jsonMap = jsonDecode(jsonData);
      //final lab = Laboratorium.fromJson(jsonMap);
      return Laboratorium.fromJson(jsonMap);
    }

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) async {
    lab = ReadJsonConfig();
    Laboratorium? labConfig = await lab;
    String namaLab = 'Nama Lab';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Profile'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 38, 38),
        foregroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 100.w),
          margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 20.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r),
          color: const Color.fromARGB(135, 245, 218, 218),),
          child:ListView(
            children: [
              const TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: InputDecoration(
                  hintText: '',
                  // hintText: 'Type your Laboratorium Name',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                  labelText: 'Laboratorium',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)
                ),
              ),
                const TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: InputDecoration(
                  hintText: 'Address: Street, City, Region etc',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                  labelText: 'Address',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)
                ),
              ),
              const TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: InputDecoration(
                  hintText: 'i.e http://elab.untidar.ac.id',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                  labelText: 'Website',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 12.w)),
              ElevatedButton.icon(
                icon: const Icon(Icons.save_alt),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainPage()));
                },
                label: const Text('Save')),
            ],
          )),
    );
  }
}
