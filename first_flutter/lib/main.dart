// ignore_for_file: deprecated_member_use

import 'package:first_flutter/Feed.dart';
import 'package:first_flutter/Login.dart';
import 'package:first_flutter/Model/CustomAppbar.dart';
import 'package:first_flutter/Register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
<<<<<<< HEAD
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'e'),
      //commentzzzzzzz
      // comment bankkk
    );
=======
  Widget build(BuildContext context){
    return MaterialApp(home : Text('Hello'),);

>>>>>>> origin/bank
=======
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deal_Demo',
      home: FeedPage(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(133, 244, 255, 1),
        backgroundColor: Color.fromRGBO(133, 244, 255, 1)
      ),
    );
>>>>>>> 8624bc70bb99e0c9913e07b2a4b6997e46909517
  }
}
