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
  final formKey = GlobalKey<FormState>();

  Profile profile = Profile();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(133, 244, 255, 1),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 1),
            child: Form(
              key:formKey,
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
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(184, 255, 249, 100)),
                                borderRadius: BorderRadius.circular(14.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(156, 0, 183, 255)),
                                borderRadius: BorderRadius.circular(14.0)),
                            fillColor: Color.fromRGBO(184, 255, 249, 100),
                            filled: true,
                            prefixIcon:
                                Icon((FontAwesomeIcons.solidCircleUser)),
                            hintText: 'Username',
                            counterText: "",
                          ),
                          maxLength: 20,
                        ),
                        //      TextField(
                        //        controller: _username,
                        //        style: TextStyle(height: 0.4),
                        //        decoration: InputDecoration(
                        //          prefixIcon:
                        //              Icon((FontAwesomeIcons.solidCircleUser)),
                        //          counterText: "",
                        //          border: OutlineInputBorder(
                        //              borderSide: BorderSide(
                        //                  color: Color.fromRGBO(184, 255, 249, 100)),
                        //              borderRadius: BorderRadius.circular(14.0)),
                        //          fillColor: Color.fromRGBO(184, 255, 249, 100),
                        //          filled: true,
                        //        ),
                        //        maxLength: 20,
                        //      ),
                        SizedBox(height: 10),
                        //         TextField(
                        //           controller: _email,
                        //           keyboardType: TextInputType.emailAddress,
                        //           style: TextStyle(height: 0.4),
                        //         ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? email) {
                            profile.email = email;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(184, 255, 249, 100)),
                                borderRadius: BorderRadius.circular(14.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(156, 0, 183, 255)),
                                borderRadius: BorderRadius.circular(14.0)),
                            fillColor: Color.fromRGBO(184, 255, 249, 100),
                            filled: true,
                            hintText: 'Email',
                            counterText: "",
                          ),
                          maxLength: 50,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onSaved: (String? password) {
                            profile.Password = password;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(184, 255, 249, 100)),
                                  borderRadius: BorderRadius.circular(14.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(156, 0, 183, 255)),
                                  borderRadius: BorderRadius.circular(14.0)),
                              fillColor: Color.fromRGBO(184, 255, 249, 100),
                              filled: true,
                              hintText: 'Password',
                              counterText: "",
                              prefixIcon: Icon((FontAwesomeIcons.lock)),
                              suffixIcon: IconButton(
                                icon: Icon(FontAwesomeIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              )),
                          maxLength: 20,
                          obscureText: _showPassword,
                        ),

                        //         TextField(
                        //         controller: password,
                        //         style: TextStyle(height: 0.4),
                        //         decoration: InputDecoration(
                        //             prefixIcon: Icon((FontAwesomeIcons.lock)),
                        //             suffixIcon: IconButton
                        //             (
                        //               icon: Icon(FontAwesomeIcons.eye),
                        //               onPressed: (){
                        //                 setState(() {
                        //                   _showPassword = !_showPassword;
                        //                 });
                        //               },
                        //             ),
                        //             counterText: "",
                        //             border: OutlineInputBorder(
                        //                 borderSide: BorderSide(
                        //                     color:
                        //                         Color.fromRGBO(184, 255, 249, 100)),
                        //                 borderRadius: BorderRadius.circular(14.0)),
                        //             fillColor: Color.fromRGBO(184, 255, 249, 100),
                        //             filled: true),
                        //         maxLength: 20,
                        //       ),
                        SizedBox(height: 10),
                        TextFormField(
                          onSaved: (String? password2) {
                            profile.Password = password2;
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(184, 255, 249, 100)),
                                  borderRadius: BorderRadius.circular(14.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(156, 0, 183, 255)),
                                  borderRadius: BorderRadius.circular(14.0)),
                              fillColor: Color.fromRGBO(184, 255, 249, 100),
                              filled: true,
                              hintText: 'Password',
                              counterText: "",
                              prefixIcon: Icon((FontAwesomeIcons.lock)),
                              suffixIcon: IconButton(
                                icon: Icon(FontAwesomeIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              )),
                          maxLength: 20,
                          obscureText: _showPassword,
                        ),
                        //       TextField(
                        //         controller: password2,
                        //         style: TextStyle(height: 0.4),
                        //         decoration: InputDecoration(
                        //             prefixIcon: Icon((FontAwesomeIcons.lock)),
                        //             suffixIcon: IconButton
                        //             (
                        //               icon: Icon(FontAwesomeIcons.eye),
                        //               onPressed: (){
                        //                 setState(() {
                        //                   _showPassword = !_showPassword;
                        //                 });
                        //               },
                        //             ),
                        //             counterText: "",
                        //             border: OutlineInputBorder(
                        //                 borderSide: BorderSide(
                        //                     color:
                        //                         Color.fromRGBO(184, 255, 249, 100)),
                        //                 borderRadius: BorderRadius.circular(14.0)),
                        //             fillColor: Color.fromRGBO(184, 255, 249, 100),
                        //             filled: true),
                        //         maxLength: 20,
                        //         obscureText: _showPassword,
                        //       ),
                        SizedBox(height: 20),
                        SizedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromRGBO(66, 194, 255, 20)),
                                  onPressed: () {
                                    formKey.currentState?.save();
                                    print(profile.username);
                                  },
                                  child: Text("Register")),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Color.fromRGBO(66, 194, 255, 20)),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
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
}
