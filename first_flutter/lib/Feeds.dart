import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Nav.dart';
import 'package:first_flutter/Model/Profile.dart';
import 'package:first_flutter/Profile.dart';
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

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsState();
}

class _FeedsState extends State<FeedsPage> {
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
  int currentTap = 0;
  final List<Widget> screens = [ProfilePage()];

void _onItemTap(int index ){
  setState(() {
    currentTap = index;
  });
}
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
              body: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FeedBox("name ${i}", "title ${i}", "gps ${i}")
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add,size: 40,),
                backgroundColor: Color.fromRGBO(66, 194, 255, 1),
                onPressed: (){

                },
              ),
              
            );
            
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
