import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Feed.dart';
import 'package:first_flutter/Model/Profile.dart';
import 'package:first_flutter/Register.dart';
import 'package:first_flutter/main.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service/FeedBox.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedState();
}

class _FeedState extends State<FeedPage> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final formKey = GlobalKey<FormState>();

  Profile profile = Profile(uid: '', username: '', password: '', email: '');
  bool _showPassword = true;
  String? _Cpassword;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(133, 244, 255, 1),
              appBar: AppBar(
                  //title: Text("test"),
                  backgroundColor: Color.fromRGBO(133, 244, 255, 1),
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon((FontAwesomeIcons.bell)),
                    )
                  ],
                  leading: Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                        onPressed: () {}, icon: Icon((FontAwesomeIcons.bars))),
                  )),

            body: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return FeedBox("name ${index}", "title ${index}", "gps ${index}");
            }),
                  
                  
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
