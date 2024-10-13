import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/file_manager.dart';
import 'package:gardner_cam/pages/main_page.dart';
import 'package:gardner_cam/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController labName =
      TextEditingController(text: lab!.name.toString());
  TextEditingController labAddress =
      TextEditingController(text: lab!.address.toString());
  TextEditingController labWeb =
      TextEditingController(text: lab!.web.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Profile'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 100.w),
          margin: EdgeInsets.symmetric(horizontal: 100.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: const Color.fromARGB(135, 245, 218, 218),
          ),
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    const Text('Current Profile:'),
                    Text(lab!.name.toString()),
                    Text(
                      lab!.address.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(lab!.web.toString())
                  ],
                ),
              ),
              TextField(
                controller: labName,
                onChanged: (value) {
                  setState(() {});
                  labName = labName;
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: const InputDecoration(
                    hintText: 'Input your Laboratorium Name',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    labelText: 'Laboratorium',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ),
              TextField(
                controller: labAddress,
                onChanged: (value) {
                  setState(() {});
                  labAddress = labAddress;
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: const InputDecoration(
                    hintText: 'Address: Street, City, Region etc',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    labelText: 'Address',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ),
              TextField(
                controller: labWeb,
                onChanged: (value) {
                  setState(() {});
                  labWeb = labWeb;
                },
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
                cursorColor: Colors.black38,
                decoration: const InputDecoration(
                    hintText: 'i.e http://elab.untidar.ac.id',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    labelText: 'Website',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 120.h, horizontal: 12.w)),
              ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    //FileManager().writeJsonFile(lab!);
                    //writeJsonConfig(labName.text, labAddress.text, labWeb.text);

                    FileManager().writeUserFile(
                        labName.text, labAddress.text, labWeb.text);

                    setState(() {});
                    FileManager().startUp();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  },
                  label: const Text('Save')),
            ],
          )),
    );
  }
}
