import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Model/UserModel.dart';
import 'package:first_flutter/Nav.dart';
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
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }
  

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final formKey = GlobalKey<FormState>();

  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  UserModel profile = UserModel(uid: '', username: '', password: '', email: '',profileUrl: '' ,bio: '' ,rate: 0, succeedcount:0 );
  bool _showPassword = true;
  String? _Cpassword;

  @override
  Widget build(BuildContext context) {
    profile.uid = uid;
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
                  body: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(66, 194, 255, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            )
                          ),
                          child: Row(
                            children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 35,
                                 backgroundImage: NetworkImage(
                                           "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  ")
                                         ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  
                  
                
            );
            
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
