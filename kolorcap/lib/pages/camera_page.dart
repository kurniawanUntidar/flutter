import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(saveConfig: SaveConfig.photoAndVideo(
          initialCaptureMode: CaptureMode.photo,
        //   photoPathBuilder: (sensors) async{
        //     final Directory extDir = await getTemporaryDirectory();
        //     final testDir =await Directory(
        //       '${extDir.path}/camerawesome',
        //     ).create(recursive: true);
        //  },
        )
        ),
      ),
    );
  }
}