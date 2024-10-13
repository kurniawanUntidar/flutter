import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/controller/file_controller.dart';
import 'package:gardner_cam/file_manager.dart';
import 'package:gardner_cam/pages/intro_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => FileController())],
    child: const MainApp(),
  ));
  //const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FileController>().readUser();
    //FileManager().startUp();
    return const ScreenUtilInit(
      designSize: Size(1440, 2560),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: MainPage(),
        home: IntroPage(),
      ),
    );
  }
}
