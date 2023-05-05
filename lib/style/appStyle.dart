import 'package:flutter/material.dart';

class AppStyles {
  static MaterialColor appColor = MaterialColor(
    Color.fromARGB(255, 29, 83, 179).value,
    const <int, Color>{
      50: Color.fromRGBO(0, 107, 79, 0.1),
      100: Color.fromRGBO(0, 137, 123, 0.2),
      200: Color.fromRGBO(0, 137, 123, 0.3),
      300: Color.fromRGBO(0, 137, 123, 0.4),
      400: Color.fromRGBO(0, 137, 123, 0.5),
      500: Color.fromRGBO(0, 137, 123, 0.6),
      600: Color.fromRGBO(0, 137, 123, 0.7),
      700: Color.fromRGBO(0, 137, 123, 0.8),
      800: Color.fromRGBO(0, 137, 123, 0.9),
      900: Color.fromRGBO(0, 137, 123, 1),
    },
  );
  static const TextStyle textStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle textStyleList = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 221, 200, 9));
  static const TextStyle textStyleInput = TextStyle(
    fontFamily: 'Cairo',
    // fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle textStyleSmall =
      TextStyle(fontFamily: 'Cairo', fontSize: 12);

  static const TextStyle navigationStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
}
