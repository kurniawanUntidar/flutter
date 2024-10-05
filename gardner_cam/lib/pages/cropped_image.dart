import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:gardner_cam/util/campare_list.dart';
import 'package:gardner_cam/pages/compare_image.dart';
import 'package:image_compare/image_compare.dart';
//import 'package:image/image.dart';
import 'package:image_cropper/image_cropper.dart';

class CroppedImage extends StatefulWidget {
  final CroppedFile image;
  const CroppedImage({super.key, required this.image});

  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
  String val = '';
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
                onPressed: () async {
                  val = await compare(widget.image);
                },
                child: Text('Analyze')),
            Padding(
              padding: const EdgeInsets.all(20),
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
                    Text('With std 1 has differences is: '),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('$val%'),
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
