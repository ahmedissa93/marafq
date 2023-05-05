import 'package:flutter/material.dart';
import 'package:marafq/api_services/api_service.dart';
import 'package:marafq/screens/auth/login.dart';
import 'package:marafq/style/appStyle.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('اضافة حجز', style: AppStyles.textStyle),
          ),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});
  @override
  // ignore: no_logic_in_create_state, library_private_types_in_public_api
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _register(username, password, email, name) async {
    var isRegister =
        (await ApiService().register(username, password, email, name));
    if (isRegister) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "تسجيل جديد",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
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
                        controller: userNameController,
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
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Name is empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'الاسم',
                            labelStyle: TextStyle(fontFamily: 'Cairo')),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'الايميل',
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
                            labelStyle: TextStyle(fontFamily: 'Cairo')),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: ElevatedButton(
                          child: const Text(
                            'تسجيل',
                            style: AppStyles.textStyle,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _register(
                                  userNameController.text,
                                  passwordController.text,
                                  emailController.text,
                                  nameController.text);
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
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            "لديك حساب؟",
                            style: AppStyles.textStyleInput,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
