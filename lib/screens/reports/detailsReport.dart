import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:marafq/api_services/api_service.dart';
import 'package:marafq/model/report_model.dart';
import 'package:marafq/style/appStyle.dart';

class DetailsReport extends StatelessWidget {
  const DetailsReport({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل البلاغ', style: AppStyles.textStyle),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: "التعليقات",
                ),
                Tab(
                  text: "تفاصيل",
                )
              ],
            ),
          ),
          body: const TabBarView(children: <Widget>[
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: const MyStatefulWidget(),
            ),
          ]),
        ));

    // Scaffold(
    //     appBar: AppBar(
    //       title: const Text('تفاصيل البلاغ', style: AppStyles.textStyle),
    //     ),
    // body: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyStatefulWidgetState createState() =>
      // ignore: no_logic_in_create_state
      _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final titles = ["صيانة مقاعد دراسية", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  late Future<List<ReportModel>> _reportModel;

  @override
  void initState() {
    super.initState();
    _getReportByUserID();
  }

  void _getReportByUserID() async {
    _reportModel = ApiService().getReportByUserID();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  final icons = [Icons.access_alarm, Icons.access_alarm, Icons.access_alarm];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Column(
                children: const <Widget>[
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "رقم البلاغ",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "ملخص البلاغ",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "تاريخ البلاغ",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "وصف البلاغ",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "الحالة",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "الهاتف",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                  Divider(),
                  Card(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          "البريد الالكتروني",
                          style: AppStyles.textStyle,
                        ),
                        subtitle: Text("data2"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
