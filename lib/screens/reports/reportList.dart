import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:marafq/api_services/api_service.dart';
import 'package:marafq/model/report_model.dart';
import 'package:marafq/style/appStyle.dart';

class ReportList extends StatelessWidget {
  ReportList({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String title = arguments['title'] ?? "البلاغات الجار ية";
    String status = arguments['status'];
    return Scaffold(
        appBar: AppBar(
          title: Text(title, style: AppStyles.textStyle),
        ),
        body: MyStatefulWidget(status: status));
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String status;

  const MyStatefulWidget({super.key, this.status = ""});

  @override
  // ignore: library_private_types_in_public_api
  _MyStatefulWidgetState createState() =>
      // ignore: no_logic_in_create_state
      _MyStatefulWidgetState(status);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String status;
  _MyStatefulWidgetState(this.status);

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
    _reportModel = ApiService().getReportByUserID(status);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  final icons = [Icons.access_alarm, Icons.access_alarm, Icons.access_alarm];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    // filterSearchResults(value);
                  },
                  // controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: FutureBuilder<List<ReportModel>>(
                future: _reportModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Card(
                              elevation: 2,
                              shape: const Border(
                                  right: BorderSide(
                                      color: Color.fromARGB(255, 221, 200, 9),
                                      width: 10)),
                              child: ListTile(
                                leading: Icon(icons[index]),
                                title: Text(
                                  snapshot.data![index].service,
                                  style: AppStyles.textStyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "رقم الطلب : ${snapshot.data![index].report_number}",
                                      style: AppStyles.textStyle,
                                    ),
                                    Text(
                                      "التاريخ :${snapshot.data![index].date}",
                                      style: AppStyles.textStyle,
                                    )
                                  ],
                                ),
                                trailing: TextButton.icon(
                                  label: const Icon(Icons.chevron_right,
                                      color: Color.fromARGB(255, 221, 200, 9)),
                                  icon: Text(
                                    snapshot.data![index].status,
                                    style: AppStyles.textStyleList,
                                  ),
                                  onPressed: () {},
                                ),
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                isThreeLine: true,
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, '/request/details')
                                },
                              ),
                            ),

                            //     child: ListTile(
                            //   title: Text(titles[index]),
                            //   subtitle: Text(subtitles[index]),
                            //   trailing: Icon(icons[index]),
                            //   onTap: () => {},
                            // )
                          );
                        }); // return Text(snapshot.data!.name);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              )),
            ],
          ),
        ));
  }
}
