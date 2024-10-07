import 'dart:math';

import 'package:gardner_cam/api/pdf_api.dart';
import 'package:gardner_cam/api/pdf_invoice_api.dart';
import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/report.dart';
import 'package:gardner_cam/model/supplier.dart';
import 'package:gardner_cam/pages/analyze_image.dart';

void pdfPage() async {
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
          no: '1',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: ''),
      reportItem(
          no: '2',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: ''),
      reportItem(
          no: '3',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: ''),
      reportItem(
          no: '4',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: ''),
      reportItem(
          no: '5',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: ''),
    ],
  );

  final pdfFile = await PdfInvoiceApi.generate(Report);

  PdfApi.openFile(pdfFile);
}
