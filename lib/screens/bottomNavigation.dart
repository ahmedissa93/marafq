import 'package:flutter/material.dart';
import 'package:marafq/screens/chat.dart';
import 'package:marafq/screens/rating.dart';
import 'package:marafq/screens/reports.dart';
import 'package:marafq/screens/dashboard.dart';
import 'package:marafq/screens/home.dart';
import 'package:marafq/screens/profile.dart';
import 'package:marafq/screens/setting.dart';
import 'package:marafq/style/appStyle.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTab = 0;
  // ignore: prefer_const_constructors
  // final List<Widget> screens = List[Home()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/report/add');
        },
        elevation: 5,
        backgroundColor: AppStyles.appColor,
        child: const Icon(Icons.add),
        splashColor: Colors.amberAccent, //<-- SEE HERE
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftBottomNavigationList(),
                rightBottomNavigationList(),
              ],
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // LEFT ROW
  Widget leftBottomNavigationList() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = Home();
              currentTab = 0;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.home,
                color: currentTab == 0 ? AppStyles.appColor : Colors.grey,
              ),
              const Text(
                "الرئيسية",
                style: AppStyles.navigationStyle,
              ),
            ],
          ),
        ),
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = Report();
              currentTab = 1;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.history,
                color: currentTab == 1 ? AppStyles.appColor : Colors.grey,
              ),
              const Text(
                "البلاغات الجارية",
                style: AppStyles.navigationStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  //RIGHT ROW
  Widget rightBottomNavigationList() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = Rating();
              currentTab = 2;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star_border,
                color: currentTab == 2 ? AppStyles.appColor : Colors.grey,
              ),
              const Text(
                "تقييم ",
                style: AppStyles.navigationStyle,
              ),
            ],
          ),
        ),
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = Chat();
              currentTab = 3;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.chat,
                color: currentTab == 3 ? AppStyles.appColor : Colors.grey,
              ),
              const Text(
                " الشات",
                style: AppStyles.navigationStyle,
              ),
            ],
          ),
        ),
        MaterialButton(
          minWidth: 40,
          onPressed: () {
            setState(() {
              currentScreen = Setting();
              currentTab = 4;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.settings,
                color: currentTab == 4 ? AppStyles.appColor : Colors.grey,
              ),
              const Text(
                "الاعدادات",
                style: AppStyles.navigationStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
