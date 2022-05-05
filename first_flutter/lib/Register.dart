import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Login.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _HomeState();
}

class _HomeState extends State<RegisterPage> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
    }
  
    //FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();
  CollectionReference userCollection = FirebaseFirestore.instance.collection("user");

  Profile profile = Profile(uid: '',username: '', password: '', email: '');
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
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 1),
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
                                        Image.asset(
                                          ('images/default.png'),
                                          width: 150,
                                          height: 150,
                                        ),
                                        SizedBox(height: 50),
                                        TextFormField(
                                          validator:
                                              RequiredValidator(errorText: "*"),
                                          onSaved: (String? username) {
                                            profile.username = username!;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        184, 255, 249, 100)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        156, 0, 183, 255)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            fillColor: Color.fromRGBO(
                                                184, 255, 249, 100),
                                            filled: true,
                                            prefixIcon: Icon((FontAwesomeIcons
                                                .solidCircleUser)),
                                            hintText: 'Username',
                                            counterText: "",
                                          ),
                                          maxLength: 20,
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "*"),
                                            EmailValidator(
                                                errorText: "not email type")
                                          ]),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (String? email) {
                                            profile.email = email!;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        184, 255, 249, 100)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        156, 0, 183, 255)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            fillColor: Color.fromRGBO(
                                                184, 255, 249, 100),
                                            filled: true,
                                            hintText: 'Email',
                                            counterText: "",
                                          ),
                                          maxLength: 50,
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          validator:
                                              RequiredValidator(errorText: "*"),
                                          onSaved: (String? password) {
                                            profile.password = password!;
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          184, 255, 249, 100)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
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
                                                  Icon((FontAwesomeIcons.lock)),
                                              suffixIcon: IconButton(
                                                icon:
                                                    Icon(FontAwesomeIcons.eye),
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword =
                                                        !_showPassword;
                                                  });
                                                },
                                              )),
                                          maxLength: 20,
                                          obscureText: _showPassword,
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          validator:
                                              RequiredValidator(errorText: "*"),
                                          onSaved: (String? password2) {
                                            _Cpassword = password2;
                                          },
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          184, 255, 249, 100)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
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
                                                  Icon((FontAwesomeIcons.lock)),
                                              suffixIcon: IconButton(
                                                icon:
                                                    Icon(FontAwesomeIcons.eye),
                                                onPressed: () {
                                                  setState(() {
                                                    _showPassword =
                                                        !_showPassword;
                                                  });
                                                },
                                              )),
                                          maxLength: 20,
                                          obscureText: _showPassword,
                                        ),
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
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();
                                                      if (profile.password !=
                                                          _Cpassword) {
                                                        print(profile.password);
                                                        print(_Cpassword);
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Password not match");
                                                        return null;
                                                      }
                                                      try {
                                                        await FirebaseAuth.instance
                                                            .createUserWithEmailAndPassword(
                                                                email: profile
                                                                    .email,
                                                                password: profile
                                                                    .password)
                                                                    
                                                            .then((value) async
                                                            {
                                                              profile.uid = value.user!.uid;
                                                          await firebase.then((value) async{
                                                              await userCollection.add({
                                                                "username":profile.username,
                                                                "email":profile.email,
                                                              });
                                                              
                                                          formKey.currentState!
                                                              .reset();

                                                          print("uid = ${profile.uid}");
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return LoginPage();
                                                          }));
                                                        });
                                                        });
                                                      } on FirebaseAuthException catch (e) {
                                                        print(e.code);
                                                        print(e.message);
                                                        Fluttertoast.showToast(
                                                            msg: e.message!,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM);
                                                      }
                                                    }
                                                  },
                                                  child: Text("Register")),
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
                                                      return MyApp();
                                                    }));
                                                  },
                                                  child: Text("Back")),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ))
                                  ],
                                ))))));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
