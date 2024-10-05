import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:gardner_cam/pages/compare_image.dart';
import 'package:image_cropper/image_cropper.dart';

class CroppedImage extends StatefulWidget {
  final CroppedFile image;
  const CroppedImage({super.key, required this.image});

  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
  String val1 = '';
  String val2 = '';
  String val3 = '';
  String val4 = '';
  String val5 = '';


  void pencetTombol() async {
    for(int i=1; i<=5; i++){
      if(i==1){val1 = await compare(widget.image,i);}
      if(i==2){val2 = await compare(widget.image,i);}
      if(i==3){val3 = await compare(widget.image,i);}
      if(i==4){val4 = await compare(widget.image,i);}
      if(i==5){val5 = await compare(widget.image,i);}      
    }
    setState(() {
      val1 = val1;
      val2 = val2;
      val3 = val3;
      val4 = val4;
      val5 = val5;
    });
  }
  void saveImage(CroppedFile imageToSave) async {
    String? message;
    try {
      final params = SaveFileDialogParams(sourceFilePath: imageToSave.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      //final finalPath = await FlutterImageUtilities.getImageProperties(imageFile);
      if (finalPath != null) {
        message = "Save to disk";
      }
    } catch (e) {
      message = "An error while save image";
    }
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analyze Image'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 252, 38, 38),
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image(
                    image: FileImage(File(widget.image.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {pencetTombol();},
                child: Text('Analyze')),
                //=======================================list 1
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image(image: AssetImage('assets/images/1.jpg')),
                    ),
                    Text('With std 1 has differences : '),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('$val1%', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 241, 216, 144),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            //=======================================list 2
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image(image: AssetImage('assets/images/2.jpg')),
                    ),
                    Text('With std 2 has differences : '),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('$val2%', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 241, 216, 144),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            //===============list 3
             Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image(image: AssetImage('assets/images/3.jpg')),
                    ),
                    Text('With std 3 has differences : '),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('$val3%', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 241, 216, 144),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            //===============list 4
             Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image(image: AssetImage('assets/images/4.jpg')),
                    ),
                    Text('With std 4 has differences : '),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('$val4%', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 241, 216, 144),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
             //===============list 5
             Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image(image: AssetImage('assets/images/5.jpg')),
                    ),
                    Text('With std 5 has differences : '),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('$val5%', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 241, 216, 144),
                    borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ));
  }
}
