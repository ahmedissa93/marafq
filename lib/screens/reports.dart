import 'package:flutter/material.dart';
import 'package:marafq/screens/reports/reportList.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Report'),
        // ),
        body: ReportList());
  }
}
