import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
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
          photoPathBuilder: (sensors) async{
            final Directory extDir = await getTemporaryDirectory();
            final testDir =await Directory(
              '${extDir.path}/camerawesome',
            ).create(recursive: true);
            if(sensors.length == 1){
              final String filePath = '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
              return SingleCaptureRequest(filePath, sensors.first);
            }else{
              // Separate pictures taken with front and back camera
                return MultipleCaptureRequest(
                  {
                    for (final sensor in sensors)
                      sensor:
                          '${testDir.path}/${sensor.position == SensorPosition.front ? 'front_' : "back_"}${DateTime.now().millisecondsSinceEpoch}.jpg',
                   },
                );
              }
            },
            videoOptions: VideoOptions(enableAudio: true,
            android: AndroidVideoOptions(bitrate:6000000,
            fallbackStrategy: QualityFallbackStrategy.lower,
             ),
             ),
             exifPreferences: ExifPreferences(saveGPSLocation: true),
          ),
          sensorConfig: SensorConfig.single(
            sensor: Sensor.position(SensorPosition.back),
            flashMode: FlashMode.auto,
            aspectRatio: CameraAspectRatios.ratio_4_3,
            zoom: 0.0,
          ),
           enablePhysicalButton: true,
           previewAlignment: Alignment.center,
           previewFit: CameraPreviewFit.contain,
           onMediaTap: (MediaCapture){
            MediaCapture.captureRequest.when(
              single: (single){
                debugPrint('single: ${single.file?.path}');
                single.file?.openRead();
              },
              multiple: (multiple){
                multiple.fileBySensor.forEach((key, value){
                  debugPrint('Multiple file token: $key ${value?.path}');
                  value?.openRead();
                });
              },
            );
          },
          availableFilters: awesomePresetFiltersList,
        ),
      ),
    );
  }
}