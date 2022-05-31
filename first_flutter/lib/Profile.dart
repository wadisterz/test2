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
import 'Model/UserModel2.dart';
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
  Future<UserModel?> readUserz()async{
    final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return UserModel.fromJson(snapshot.data()!);
    }
  //if(snapshot.exists){
  //}
  }
  Widget BuildUser(UserModel user){
    if(user.username == null){
                             return Text("null",
                               style: TextStyle(
                                   fontSize: 20,
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold),
                               overflow: TextOverflow.ellipsis,
                               maxLines: 1,
                             );
    }
    else{
                                  user.username = user.username!;
                             return Text(user.username!,
                               style: TextStyle(
                                   fontSize: 20,
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold),
                               overflow: TextOverflow.ellipsis,
                               maxLines: 1,
                             );
                             
    }
  }
    

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
              body: Column(
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(66, 194, 255, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )),
                    ),
                    Positioned(
                      top: 1,
                      child: CircleAvatar(
                        radius: 40,
                                     backgroundImage: AssetImage('images/default.png'),
                      ),
                    ),
                             FutureBuilder<UserModel?>(
                               future: readUserz(),
                               builder: (context, snapshot) {
                                 if(snapshot.hasData){
                                   final user = snapshot.data!;
                                   print("hasdata");
                                   print(user);
                                   return user == null 
                                   ? Center(child: Text("NoUsers"))
                                   :BuildUser(user);
                                 }else{
                               return Text("test",
                                 style: TextStyle(
                                     fontSize: 20,
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold),
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 1,
                               );
                                 }
                             }
                             ),
                    
                  ]),
                  Row(children: [
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 50),
                      height: 120,
                      width: 120,
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
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 50),
                      height: 120,
                      width: 120,
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
                    )
                  ],)
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
