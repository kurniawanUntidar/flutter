import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gardner_cam/pages/analyze_image.dart';
import 'package:gardner_cam/pages/help_page.dart';
import 'package:gardner_cam/pages/profile_page.dart';
import 'package:gardner_cam/pages/setting_page.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void pickImage(bool pickGalleryImage) async {
    XFile? image;
    final picker = ImagePicker();

    if (pickGalleryImage == true) {
      image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      image = await picker.pickImage(source: ImageSource.camera);
    }

    if (image != null) {
      final croppedImage = await cropImages(image);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => AnalyzeImage(
                image: croppedImage,
              )),
        ),
      );
    }
  }

  Future<CroppedFile> cropImages(XFile image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio7x5,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color.fromARGB(255, 252, 38, 38),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          cropStyle: CropStyle.circle,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    return croppedFile!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.deepOrange,
              image: DecorationImage(
                image: AssetImage("assets/images/pattern.png"),
                fit: BoxFit.fitWidth,
                repeat: ImageRepeat.repeat,
                //invertColors: true,
              )),
        ),
        title: Stack(children: [
          Text(
            'GARDNER CAM',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4
                  ..color = const Color.fromARGB(255, 107, 28, 4)),
          ),
          const Text(
            'GARDNER CAM',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      //************************************************************************/
      drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 248, 111, 69),
          child: Column(
            children: [
              DrawerHeader(
                child: SizedBox(
                  width: 250.w,
                  height: 250.h,
                  child: const Image(
                      image: AssetImage('assets/icons/play_store_512.png')),
                ),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'P R O F I L E',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'S E T T I N G',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage()));
                  }),
              ListTile(
                  leading: const Icon(
                    Icons.help_center,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'H E L P',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpPage()));
                  })
            ],
          )),

      //************************************************************************/
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: const Color.fromARGB(255, 245, 233, 191),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                pickImage(false);
              },
              child: Card(
                elevation: 5,
                color: Colors.deepOrange,
                child: Row(
                  children: [
                    Container(
                      height: 300.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Image.asset(
                        'assets/icons/CaptureBotle.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Capture Image',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 80.w,
                              color: Colors.white),
                        ),
                        Container(
                          width: 980.w,
                          child: Text(
                            'Use camera modul to take a picture from supernatant liquid test sample',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                pickImage(true);
              },
              child: Card(
                elevation: 5,
                color: Colors.deepOrange,
                child: Row(
                  children: [
                    Container(
                      height: 300.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Image.asset(
                        'assets/icons/PickGalery.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Pick Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 80.w,
                              color: Colors.white),
                        ),
                        Container(
                          width: 980.w,
                          child: Text(
                            'Pick image of supernatant liquid test sample on phone gallery',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            //Text(context.read<FileController>()=> user),
            // ElevatedButton(
            //   onPressed: () {
            //     pickImage(false);
            //   },
            //   style: const ButtonStyle(
            //       backgroundColor: MaterialStatePropertyAll<Color>(
            //           Color.fromARGB(255, 252, 38, 38))),
            //   child: const Text(
            //     'Capture Image',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),

            // /* =============== Pick Image Fromm Galery ================ */
            // ElevatedButton(
            //   onPressed: () {
            //     pickImage(true);
            //   },
            //   style: const ButtonStyle(
            //       backgroundColor: MaterialStatePropertyAll<Color>(
            //           Color.fromARGB(255, 252, 38, 38))),
            //   child: const Text(
            //     'Pick Gallery Image',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
