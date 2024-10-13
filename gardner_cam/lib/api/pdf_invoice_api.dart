import 'dart:io';
import 'package:gardner_cam/api/pdf_api.dart';
import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/report.dart';
import 'package:gardner_cam/model/user.dart';
import 'package:gardner_cam/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Report reportPdf) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(reportPdf),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(reportPdf),
        buildInvoice(reportPdf),
        Divider(),
        buildTotal(reportPdf),
      ],
      footer: (context) => buildFooter(reportPdf),
    ));

    return PdfApi.saveDocument(name: 'gardnerCam_report.pdf', pdf: pdf);
  }

  static Widget buildHeader(Report invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.laboratorium),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(ReportInfo info) {
    //final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Report Number:',
      'Test Date:',
      'Light Intensity (lux):'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(User? laboratorium) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(laboratorium!.name!.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(laboratorium.address!.toString()),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(laboratorium.web!.toString()),
        ],
      );

  static Widget buildTitle(Report invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REPORT',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Report invoice) {
    final headers = ['No', 'Description', 'Differences'];
    final data = invoice.items.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.no,
        item.description,
        item.differences,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Report invoice) {
    double dif1 = double.parse(invoice.items[0].differences);
    double dif2 = double.parse(invoice.items[1].differences);
    double dif3 = double.parse(invoice.items[2].differences);
    double dif4 = double.parse(invoice.items[3].differences);
    double dif5 = double.parse(invoice.items[4].differences);

    ReportItem minimal;
    double valMin;

    if (dif1 > dif2) {
      minimal = invoice.items[1];
      valMin = double.parse(minimal.differences);
    } else {
      minimal = invoice.items[0];
      valMin = double.parse(minimal.differences);
    }
    if (valMin > dif3) {
      minimal = invoice.items[2];
      valMin = double.parse(minimal.differences);
    } else {
      minimal = minimal;
      valMin = double.parse(minimal.differences);
    }
    if (valMin > dif4) {
      minimal = invoice.items[3];
      valMin = double.parse(minimal.differences);
    } else {
      minimal = minimal;
      valMin = double.parse(minimal.differences);
    }
    if (valMin > dif5) {
      minimal = invoice.items[4];
      valMin = double.parse(minimal.differences);
    } else {
      minimal = minimal;
      valMin = double.parse(minimal.differences);
    }
    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Lowest Differences :',
                  value: '$valMin %',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Closest Similarity on std no',
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  value: minimal.no,
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Report invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
//          buildSimpleText(title: 'Address', value: invoice.laboratorium.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          //   buildSimpleText(
          //       title: 'website', value: invoice.laboratorium.web),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
