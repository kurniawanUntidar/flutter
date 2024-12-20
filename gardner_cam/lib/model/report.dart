import 'package:gardner_cam/model/customer.dart';
import 'package:gardner_cam/model/user.dart';

class Report {
  final ReportInfo info;
  final User? laboratorium;
  // final Laboratorium? laboratorium;
  final Customer customer;
  final List<ReportItem> items;

  const Report({
    required this.info,
    required this.laboratorium,
    required this.customer,
    required this.items,
  });
}

class ReportInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const ReportInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class ReportItem {
  final String no;
  final String description;
  final String differences;

  const ReportItem(
      {required this.no, required this.description, required this.differences});
}
