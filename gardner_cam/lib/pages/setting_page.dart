import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void pickImage(String no) async {
    XFile? image;
    final picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final croppedImage = await cropImages(image, no);

      if (!mounted) return;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: ((context) => AnalyzeImage(
      //           image: croppedImage,
      //         )),
      //   ),
      // );
    }
  }

  Future<CroppedFile> cropImages(XFile image, String no) async {
    final croppedFile = await ImageCropper().cropImage(
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

    return croppedFile!;
  }

  @override
  Widget build(BuildContext context) {
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
                          GestureDetector(
                            onTap: () {
                              pickImage('1');
                            },
                            child: Stack(children: [
                              Container(
                                width: 200.w,
                                height: 200.h,
                                clipBehavior: Clip.antiAlias,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: const Image(
                                  image: AssetImage('assets/images/1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Text(
                                    '1',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(Icons.camera_alt)),
                            ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImage('2');
                            },
                            child: Stack(children: [
                              Container(
                                width: 200.w,
                                height: 200.h,
                                clipBehavior: Clip.antiAlias,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: const Image(
                                  image: AssetImage('assets/images/2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Text(
                                    '2',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  width: 200.w,
                                  height: 200.h,
                                  child: const Icon(Icons.camera_alt)),
                            ]),
                          ),
                          Container(
                            width: 200.w,
                            height: 200.h,
                            clipBehavior: Clip.antiAlias,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Image(
                              image: AssetImage('assets/images/3.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 200.w,
                            height: 200.h,
                            clipBehavior: Clip.antiAlias,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Image(
                              image: AssetImage('assets/images/4.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 200.w,
                            height: 200.h,
                            clipBehavior: Clip.antiAlias,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Image(
                              image: AssetImage('assets/images/5.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
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
