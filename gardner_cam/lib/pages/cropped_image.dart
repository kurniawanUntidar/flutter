import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:gardner_cam/pages/compare_image.dart';
//import 'package:image/image.dart';
import 'package:image_cropper/image_cropper.dart';

class CroppedImage extends StatefulWidget {
  final CroppedFile image;
  const CroppedImage({super.key, required this.image});

  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
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

  // void compare(File gambar1, File gambar2) async {
  //   //-----membaca kedua gambar sebagai bytes
  //   List<int> bytes1 = gambar1.readAsBytesSync();
  //   List<int> bytes2 = gambar2.readAsBytesSync();

  //   //---mengkode kedua gambar menjadi object image
  //   Image img1 = decodeImage(Uint8List.fromList(bytes1));
  //   Image img2 = decodeImage(Uint8List.fromList(bytes2));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropped Image'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 252, 38, 38),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: FileImage(File(widget.image.path)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(
                  image: AssetImage('assets/images/1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            /*child: InteractiveViewer(
                  child: Image(
                image: FileImage(
                  File(widget.image.path),
                ),
              )),
            ),*/
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        compare(widget.image);
                      },
                      child: Text(
                        'Analize',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 32, 2, 2)),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        saveImage(widget.image);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 32, 2, 2)),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
