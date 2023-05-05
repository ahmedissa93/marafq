import 'package:flutter/material.dart';
import 'package:marafq/api_services/api_service.dart';
import 'package:marafq/screens/auth/register.dart';
import 'package:marafq/screens/bottomNavigation.dart';
import 'package:marafq/screens/home.dart';
import 'package:marafq/style/appStyle.dart';
// import 'package:ranan/screen/home/headerList.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: AppStyles.appColor,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("")),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late var _isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _login(username, password) async {
    _isLoggedIn = (await ApiService().login(username, password));
    if (_isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()));
      // Navigator.pushNamed(context, '/home');
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'User Name is empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'اسم المستخدم',
                        labelStyle: TextStyle(fontFamily: 'Cairo')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Password is empty';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'كلمة المرور',
                      labelStyle: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'دخول',
                        style: AppStyles.textStyle,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _login(nameController.text, passwordController.text);
                        }
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    // Add what you want to do on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "تسجيل جديد",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Text(
                        "ليس لديك حساب؟",
                        style: AppStyles.textStyleInput,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
