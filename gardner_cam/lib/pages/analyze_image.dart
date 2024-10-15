import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardner_cam/api/pdf_api.dart';
import 'package:gardner_cam/api/pdf_invoice_api.dart';
import 'package:gardner_cam/controller/file_controller.dart';
import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/report.dart';
import 'package:gardner_cam/model/user.dart';
import 'package:gardner_cam/pages/compare_image.dart';
import 'package:gardner_cam/pages/main_page.dart';
import 'package:gardner_cam/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class AnalyzeImage extends StatefulWidget {
  final CroppedFile image;
  const AnalyzeImage({super.key, required this.image});

  @override
  State<AnalyzeImage> createState() => _AnalyzeImageState();
}

class _AnalyzeImageState extends State<AnalyzeImage> {
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
    final dueDate = date.add(const Duration(days: 7));

    final reportPage = Report(
      laboratorium: await lab,
      // laboratorium: const Laboratorium(
      //   name: 'GARDNER CAM APP REPORT',
      //   address: 'Laboratorium Teknik Sipil Universitas Tidar Magelang',
      //   web: 'https://elab.untidar.ac.id',
      // ),

      customer: const Customer(
        name: '',
        address: '',
      ),
      info: ReportInfo(
        date: date,
        dueDate: dueDate,
        description: 'ASTM-C40 using Eucladian Color Distance Algorithm',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        ReportItem(
            no: '1',
            description: ' Compare to standard color 1st has similarities:',
            differences: val1),
        ReportItem(
            no: '2',
            description: ' Compare to standard color 2nd has similarities:',
            differences: val2),
        ReportItem(
            no: '3',
            description: ' Compare to standard color 3rd has similarities:',
            differences: val3),
        ReportItem(
            no: '4',
            description: ' Compare to standard color 4th has similarities:',
            differences: val4),
        ReportItem(
            no: '5',
            description: ' Compare to standard color 5th has similarities:',
            differences: val5),
      ],
    );

    final pdfFile = await PdfInvoiceApi.generate(reportPage);

    PdfApi.openFile(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Analyze Image'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(20.h),
                width: 400.w,
                height: 400.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 138, 63, 1)),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image(
                    image: FileImage(File(widget.image.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.assessment_outlined),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  pencetTombol();
                },
                label: const Text('Analyze')),
            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)),
            //=======================================list 1
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  const Text('With 1st color std has similarities:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Text(
                      '$val1%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //=======================================list 2
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  const Text('With 2nd color std has similarities:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Text(
                      '$val2%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //=======================================list 3
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  const Text('With 3rd color std has similarities:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Text(
                      '$val3%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //=======================================list 4
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  const Text('With 4th color std has similarities:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Text(
                      '$val4%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //=======================================list 5
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 216, 144),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  const Text('With 5th color std has similarities:'),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                    child: Text(
                      '$val5%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)),

            ElevatedButton.icon(
                icon: const Icon(Icons.picture_as_pdf_outlined),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  pdfPage1();
                },
                label: const Text('Save Report')),

            ElevatedButton.icon(
                icon: const Icon(Icons.home),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                label: const Text('Back  Home')),

            Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)),
          ],
        ));
  }
}
