// ignore_for_file: deprecated_member_use

import 'package:first_flutter/Register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deal_Demo',
      home: RegisterPage(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(133, 244, 255, 1),
        backgroundColor: Color.fromRGBO(133, 244, 255, 1)
      ),
    );
  }
}
