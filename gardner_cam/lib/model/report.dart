import 'dart:ffi';

import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/supplier.dart';
import 'package:image/image.dart';

class report {
  final reportInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<reportItem> items;

  const report({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class reportInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const reportInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class reportItem {
  final Image stdImage;
  final String no;
  final String description;
  final String differences;

  const reportItem(
      {required this.stdImage, required this.no, required this.description, required this.differences});
}
