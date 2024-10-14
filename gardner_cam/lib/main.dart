import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/controller/file_controller.dart';
import 'package:gardner_cam/file_manager.dart';
import 'package:gardner_cam/pages/intro_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => FileController())],
        child: MainApp(),
      ),
    );

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Start Up");
    FileManager().startUp();
    print("Image path:");
    FileManager().cekImageFile();
    for (int i = 1; i < 6; i++) {
      context.read<FileController>().readImage(i);
    }
    return const ScreenUtilInit(
      designSize: Size(1440, 2560),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: MainPage(),
        home: IntroPage(),
        //home: SettingPage(),
      ),
    );
  }
}
