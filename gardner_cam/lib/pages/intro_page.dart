import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/controller/file_controller.dart';
import 'package:gardner_cam/pages/main_page.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // for (int i = 1; i < 6; i++) {
    //   context.read<FileController>().readImage(i);
    // }
    return Scaffold(
      body: Container(
        //color: Color.fromARGB(255, 230, 214, 214),
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: const [
          Color.fromARGB(255, 240, 235, 235),
          Color.fromARGB(255, 196, 160, 160)
        ], radius: 10.r)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //     padding:
              //         EdgeInsets.symmetric(vertical: 150.h, horizontal: 0.w)),
              Image(
                image: const AssetImage('assets/icons/play_store_512.png'),
                height: 512.h,
              ),
              // title
              SizedBox(
                height: 100.h,
              ),
              Text(
                'Take a Shoot and Compare it..',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60.h,
                    color: const Color.fromARGB(255, 73, 73, 73)),
              ),
              SizedBox(
                height: 100.h,
              ),
              Text(
                'Glass Color Standard Replacement Method for Organic Impurities in Fine Aggregates for Concrate. (SNI 2816:2014 or ASTM-C40)',
                style: TextStyle(
                  color: const Color.fromARGB(255, 73, 73, 73),
                  fontSize: 48.h,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100.h,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage())),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.h, horizontal: 125.h),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 73, 73, 73),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.h,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
