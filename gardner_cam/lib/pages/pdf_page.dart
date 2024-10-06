import 'dart:math';

import 'package:gardner_cam/api/pdf_api.dart';
import 'package:gardner_cam/api/pdf_invoice_api.dart';
import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/invoice.dart';
import 'package:gardner_cam/model/supplier.dart';

void pdfPage() async {
  final date = DateTime.now();
  final dueDate = date.add(Duration(days: 7));

  final invoice = Invoice(
    supplier: Supplier(
      name: 'GARDNER CAM APP REPORT',
      address: 'Laboratorium Teknik Sipil Universitas Tidar Magelang',
      paymentInfo: 'https://elab.untidar.ac.id',
    ),
    customer: Customer(
      name: 'Nama User',
      address: 'Alamat user',
    ),
    info: InvoiceInfo(
      date: date,
      dueDate: dueDate,
      description: 'ASTM-C40 using Eucladian Color Distance Algorithm',
      number: '${DateTime.now().year}-9999',
    ),
    items: [
      InvoiceItem(
          no: '1',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: 0),
      InvoiceItem(
          no: '2',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: 0),
      InvoiceItem(
          no: '3',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: 0),
      InvoiceItem(
          no: '4',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: 0),
      InvoiceItem(
          no: '5',
          description: 'Compare With Standard Color Number 1 has differences :',
          differences: 0),
    ],
  );

  final pdfFile = await PdfInvoiceApi.generate(invoice);

  PdfApi.openFile(pdfFile);
}
