import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_flutter/Model/UserModel.dart';
import 'package:first_flutter/MyDeals.dart';
import 'package:first_flutter/service/AddPostButton.dart';
import 'package:first_flutter/Nav.dart';
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

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  UserModel profile = UserModel(
      uid: '',
      username: '',
      password: '',
      email: '',
      profileUrl: '',
      bio: '',
      rate: 0,
      succeedcount: 0);
  bool _showPassword = true;
  String? _Cpassword;
  int currentTap = 0;
  final userRef = FirebaseFirestore.instance.collection('user');
  getUserbyId() {
    final String id = getuser(auth.currentUser?.uid);
    userRef.doc(id).get().then((DocumentSnapshot doc) {});
  }

  final List<Widget> screens = [ProfilePage()];
  String getuser(String? string) {
    if (string == null) {
      return 'null';
    } else {
      return string;
    }
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
                        onPressed: (
                          
                        ) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return NavPage();
                          }));
                        }, icon: Icon((FontAwesomeIcons.arrowLeft))),
                  )),
              body: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(66, 194, 255, 1),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(0.0, 3.0))
                                ]),
                            width: 120,
                            height: 100,
                            child: Image.asset(
                              'images/profileicon.png',
                              height: 72,
                              width: 72,
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return MyDeals();
                            }));},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(66, 194, 255, 1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0.0, 3.0))
                                  ]),
                              width: 120,
                              height: 100,
                              child: Image.asset(
                                'images/dealicon.png',
                                height: 72,
                                width: 72,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height:450),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 123, 171, 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0.0, 3.0))
                          ]),
                      width: 350,
                      height: 80,
                      child: Center(
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
