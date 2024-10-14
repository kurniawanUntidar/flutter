import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/controller/file_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void pickImage(int no) async {
    XFile? image;
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final croppedImage = await cropImages(image, no);

      if (!mounted) return;
      context.read<FileController>().writeImage(croppedImage, no);
      //FileManager().writeImageFile(croppedImage, no);
    }
  }

  Future<Uint8List> cropImages(XFile image, int no) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image for Std no:$no',
          toolbarColor: const Color.fromARGB(255, 252, 38, 38),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          cropStyle: CropStyle.circle,
        ),
        IOSUiSettings(
          title: 'Crop Image for Std no:$no',
        ),
      ],
    );
    Uint8List imageCroppList = await croppedFile!.readAsBytes();

    return croppedFile!.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    // updateImage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting App'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Container(
          //padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r),
            color: const Color.fromARGB(255, 245, 233, 191),
          ),
          child: ListView(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h)),
                    Text(
                      'Take Standard Color',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60.h,
                          color: Colors.black87),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.h, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(children: [
                            Container(
                              width: 200.w,
                              height: 200.h,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: context.select(
                                (FileController controller) =>
                                    controller.imageByteList1 != null
                                        ? Image.memory(
                                            controller.imageByteList1!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/1.jpg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 200.h,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80.h,
                                    shadows: const [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                pickImage(1);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(2, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                          /* ============================================================*/
                          Stack(children: [
                            Container(
                              width: 200.w,
                              height: 200.h,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: context.select(
                                (FileController controller) =>
                                    controller.imageByteList2 != null
                                        ? Image.memory(
                                            controller.imageByteList2!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/2.jpg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 200.h,
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80.h,
                                    shadows: const [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                pickImage(2);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(2, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                          /* ============================================================*/
                          Stack(children: [
                            Container(
                              width: 200.w,
                              height: 200.h,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: context.select(
                                (FileController controller) =>
                                    controller.imageByteList3 != null
                                        ? Image.memory(
                                            controller.imageByteList3!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/3.jpg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 200.h,
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80.h,
                                    shadows: const [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                pickImage(3);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(2, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                          /* ============================================================*/
                          Stack(children: [
                            Container(
                              width: 200.w,
                              height: 200.h,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: context.select(
                                (FileController controller) =>
                                    controller.imageByteList4 != null
                                        ? Image.memory(
                                            controller.imageByteList4!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/4.jpg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 200.h,
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80.h,
                                    shadows: const [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                pickImage(4);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(2, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                          /* ============================================================*/
                          Stack(children: [
                            Container(
                              width: 200.w,
                              height: 200.h,
                              clipBehavior: Clip.antiAlias,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: context.select(
                                (FileController controller) =>
                                    controller.imageByteList5 != null
                                        ? Image.memory(
                                            controller.imageByteList5!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/5.jpg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 200.w,
                                height: 200.h,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 80.h,
                                      shadows: const [
                                        Shadow(
                                          color: Color.fromARGB(
                                              255, 214, 214, 214),
                                          offset: Offset(1, 1),
                                          blurRadius: 1,
                                        ),
                                      ]),
                                )),
                            GestureDetector(
                              onTap: () {
                                pickImage(5);
                              },
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                        offset: Offset(2, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  )),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
