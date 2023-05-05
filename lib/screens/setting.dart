import 'package:flutter/material.dart';
import 'package:marafq/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Logout'),
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
        ),
      ),
    );
  }
}
