import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/api/pdf_api.dart';
import 'package:gardner_cam/api/pdf_invoice_api.dart';
import 'package:gardner_cam/main.dart';
import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/report.dart';
import 'package:gardner_cam/model/supplier.dart';
import 'package:gardner_cam/pages/compare_image.dart';
import 'package:image_cropper/image_cropper.dart';

class analyzeImage extends StatefulWidget {
  final CroppedFile image;
  const analyzeImage({super.key, required this.image});

  @override
  State<analyzeImage> createState() => _analyzeImageState();
}

class _analyzeImageState extends State<analyzeImage> {
  String val1 = '';
  String val2 = '';
  String val3 = '';
  String val4 = '';
  String val5 = '';

  void pencetTombol() async {
    for (int i = 1; i <= 5; i++) {
      if (i == 1) {
        val1 = await compare(widget.image, i);
      }
      if (i == 2) {
        val2 = await compare(widget.image, i);
      }
      if (i == 3) {
        val3 = await compare(widget.image, i);
      }
      if (i == 4) {
        val4 = await compare(widget.image, i);
      }
      if (i == 5) {
        val5 = await compare(widget.image, i);
      }
    }
    setState(() {
      val1 = val1;
      val2 = val2;
      val3 = val3;
      val4 = val4;
      val5 = val5;
    });
  }

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

  void pdfPage1() async {
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    final Report = report(
      supplier: Supplier(
        name: 'GARDNER CAM APP REPORT',
        address: 'Laboratorium Teknik Sipil Universitas Tidar Magelang',
        paymentInfo: 'https://elab.untidar.ac.id',
      ),
      customer: Customer(
        name: 'Nama User',
        address: 'Alamat user',
      ),
      info: reportInfo(
        date: date,
        dueDate: dueDate,
        description: 'ASTM-C40 using Eucladian Color Distance Algorithm',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        reportItem(
          stdImage: await getImageAsList('assets/images/1.jpg'),
          no: '1',
          description:
                'Compare With Standard Color Number 1 has differences :',
          differences: val1),
        reportItem(
          stdImage: await getImageAsList('assets/images/2.jpg'),
          no: '2',
          description:
                'Compare With Standard Color Number 2 has differences :',
          differences: val2),
        reportItem(
          stdImage: await getImageAsList('assets/images/3.jpg'),
            no: '3',
            description:
                'Compare With Standard Color Number 3 has differences :',
            differences: val3),
        reportItem(
          stdImage: await getImageAsList('assets/images/4.jpg'),
          no: '4',
          description:
                'Compare With Standard Color Number 4 has differences :',
          differences: val4),
        reportItem(
          stdImage: await getImageAsList('assets/images/5.jpg'),
          no: '5',
          description:
                'Compare With Standard Color Number 5 has differences :',
          differences: val5),
      ],
    );

    final pdfFile = await PdfInvoiceApi.generate(Report);

    PdfApi.openFile(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analyze Image'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 252, 38, 38),
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(12.h),
                width: 250.w,
                height: 250.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 138, 63, 1)),
                child: Container(
                  margin: EdgeInsets.all(2),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image(
                    image: FileImage(File(widget.image.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                icon: Icon(Icons.assessment_outlined),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  pencetTombol();
                },
                label: Text('Analyze')),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w)),
            //=======================================list 1
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/1.jpg')),
                  ),
                  Text(' Compare with std 1 has differences:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    child: Text(
                      '$val1%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            //=======================================list 2
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/2.jpg')),
                  ),
                  Text(' Compare with std 2 has differences: '),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    child: Text(
                      '$val2%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            //===============list 3
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/3.jpg')),
                  ),
                  Text(' Compare with std 3 has differences: '),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    child: Text(
                      '$val3%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
            ),

            //===============list 4
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/4.jpg')),
                  ),
                  Text(' Compare with std 4 has differences: '),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    child: Text(
                      '$val4%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
            ),

            //===============list 5
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image(image: AssetImage('assets/images/5.jpg')),
                  ),
                  Text('Compare with std 5 has differences: '),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    child: Text(
                      '$val5%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w)),

            ElevatedButton.icon(
                icon: Icon(Icons.picture_as_pdf_outlined),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  pdfPage1();
                },
                label: Text('Save Report')),

            ElevatedButton.icon(
                icon: Icon(Icons.home),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainApp()));
                },
                label: Text('Back  Home')),
          ],
        ));
  }
}
