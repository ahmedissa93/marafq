import 'package:flutter/material.dart';
import 'package:marafq/style/appStyle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'الرئيسية',
            style: AppStyles.textStyle,
          ),
        ),
        body: _HomeStatelssWidget());
  }
}

class _HomeStatelssWidget extends StatelessWidget {
  _HomeStatelssWidget({super.key});
  final titles = [
    "بلاغات في انتظار التقييم",
    "البلاغات الجارية",
    "البلاغات المكتملة"
  ];
  final subtitles = [
    "البلاغات المنجزة وابنتظار الموافقة او رفض",
    "البلاغات قيد العمل",
    "البلاغات المنجزة"
  ];
  final icons = [
    'assets/images/list_1.jpeg',
    'assets/images/list_2.jpeg',
    'assets/images/list_3.jpeg'
  ];
  final status = ['2', '1', '3'];
  final counts = ['10', '20', '30'];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Card(
                            elevation: 2,
                            // shape: const Border(
                            //     right: BorderSide(
                            //         color: Color.fromARGB(255, 221, 200, 9),
                            //         width: 10)),
                            child: ListTile(
                              leading:
                                  Image.asset(icons[index], fit: BoxFit.cover),
                              title: Text(
                                titles[index],
                                style: AppStyles.textStyle,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subtitles[index],
                                    style: AppStyles.textStyleSmall,
                                  ),
                                ],
                              ),
                              trailing: TextButton.icon(
                                label: const Icon(Icons.chevron_right,
                                    color: Color.fromARGB(255, 221, 200, 9)),
                                icon: Text(
                                  counts[index],
                                  style: AppStyles.textStyleList,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/report/list',
                                      arguments: {
                                        'title': titles[index],
                                        'status': status[index]
                                      });
                                },
                              ),
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              isThreeLine: true,
                              onTap: () => {
                                Navigator.pushNamed(context, '/report/list',
                                    arguments: {
                                      'title': titles[index],
                                      'status': status[index]
                                    })
                              },
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ));
  }
}
