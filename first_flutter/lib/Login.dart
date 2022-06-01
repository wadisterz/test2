import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Feeds.dart';
import 'package:first_flutter/Model/UserModel.dart';
import 'package:first_flutter/Nav.dart';
import 'package:first_flutter/Register.dart';
import 'package:first_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();

  }
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final formKey = GlobalKey<FormState>();

  UserModel profile = UserModel(uid: '', username: '', password: '', email: '',profileUrl: '' ,bio: '' ,rate: 0, succeedcount:0 );
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
                body: Container(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 150, 20, 1),
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                                padding: EdgeInsets.fromLTRB(20, 50, 20, 1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Column(
                                      children: [
                                        SizedBox(height: 50),
                                        TextFormField(
                                          validator:
                                              RequiredValidator(errorText: "*"),
                                          onSaved: (String? username) {
                                            profile.username = username!;
                                            profile.email = username;
                                          },
                                          
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const  BorderSide(
                                                    color: Color.fromRGBO(
                                                        184, 255, 249, 100)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color:  Color.fromARGB(
                                                        156, 0, 183, 255)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            fillColor: const Color.fromRGBO(
                                                184, 255, 249, 100),
                                            filled: true,
                                            prefixIcon: const Icon((FontAwesomeIcons
                                                .solidCircleUser)),
                                            hintText: 'Username or Email',
                                            counterText: "",
                                          ),
                                          maxLength: 50,
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          validator:
                                              RequiredValidator(errorText: "*"),
                                          onSaved: (String? password) {
                                            profile.password = password!;
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide:  const BorderSide(
                                                      color: Color.fromRGBO(
                                                          184, 255, 249, 100)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color.fromARGB(
                                                          156, 0, 183, 255)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0)),
                                              fillColor: Color.fromRGBO(
                                                  184, 255, 249, 100),
                                              filled: true,
                                              hintText: 'Password',
                                              counterText: "",
                                              prefixIcon:
                                                 const Icon((FontAwesomeIcons.lock)),
                                              suffixIcon: IconButton(
                                                icon:
                                                    const Icon(FontAwesomeIcons.eye),
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword =
                                                        !_showPassword;
                                                  });
                                                },
                                              )
                                              ),
                                          maxLength: 20,
                                          obscureText: _showPassword,
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(height: 20),
                                        SizedBox(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: ElevatedButton(
                                                
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Color.fromRGBO(
                                                                  66,
                                                                  194,
                                                                  255,
                                                                  20)),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) 
                                                      {
                                                      formKey.currentState!
                                                          .save();
                                                      try {
                                                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: profile.email!, password: profile.password!)
                                                        .then((value) {
                                                            formKey.currentState!.reset();
                                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                            return NavPage();
                                                           }));

                                                        });
                                                        
                                                      } on FirebaseAuthException catch (e) {
                                                        print(profile.email);
                                                        print(profile.password);
                                                        Fluttertoast.showToast(msg: e.message!,
                                                        gravity: ToastGravity.CENTER
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Text("LOGIN")),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            SizedBox(
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Color.fromRGBO(
                                                                  66,
                                                                  194,
                                                                  255,
                                                                  20)),
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return RegisterPage();
                                                    }));
                                                  },
                                                  child: Text("REGISTER")),
                                            ),
                                          ],
                                        )),
                                      ],
                                    )),
                                        Image.asset(
                                          ('images/handshake.png'),
                                          fit: BoxFit.contain,
                                        ),
                                  ],
                                  
                                ))))));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
