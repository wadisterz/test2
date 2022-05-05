import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Profile.dart';
import 'package:first_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedState();
}

class _FeedState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Color.fromRGBO(133, 244, 255, 1),
    );
      
    

  }
}
