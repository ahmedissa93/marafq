import 'package:flutter/material.dart';
import 'package:marafq/screens/auth/login.dart';
import 'package:marafq/screens/bottomNavigation.dart';
import 'package:marafq/screens/home.dart';
import 'package:marafq/screens/reports/addReport.dart';
import 'package:marafq/screens/reports/detailsReport.dart';
import 'package:marafq/screens/reports/reportList.dart';
import 'package:marafq/style/appStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: status == false ? const Login() : const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => const Home(),
        '/report/add': (context) => const AddReport(),
        '/report/list': (context) => ReportList(),
        '/request/details': (context) => const DetailsReport(),
      },
      theme: ThemeData(
        primarySwatch: AppStyles.appColor,
      ),
      // home: const BottomNavigation(),
      home: Directionality(
        // add this
        textDirection: TextDirection.rtl,
        child: SplashScreen(
          seconds: 5,
          title: const Text(
            'صيانة المرافق',
            style: AppStyles.textStyleSmall,
            textScaleFactor: 2,
          ),
          navigateAfterSeconds: const BottomNavigation(),
          backgroundColor: Colors.white,
          image: Image.asset('assets/images/logo.png'),
          loadingText: const Text("Loading..."),
          photoSize: 100.0,
        ),
      ),
    );
  }
}
