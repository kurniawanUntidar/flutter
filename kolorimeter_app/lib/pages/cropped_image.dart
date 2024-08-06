import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
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
        title: const Text('Cropped Image'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 252, 38, 38),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: InteractiveViewer(
                  child: Image(
                image: FileImage(
                  File(widget.image.path),
                ),
              )),
            ),
            ElevatedButton(
                onPressed: () {
                  saveImage(widget.image);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: const Color.fromARGB(255, 32, 2, 2)),
                ))
          ],
        ),
      ),
    );
  }
}
