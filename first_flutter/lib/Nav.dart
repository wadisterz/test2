import 'dart:ffi';
import 'package:first_flutter/Login.dart';
import 'package:first_flutter/Menu.dart';
import 'package:first_flutter/Message.dart';
import 'package:first_flutter/Model/UserModel.dart';
import 'package:first_flutter/Noti.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/Nav.dart';
import 'package:first_flutter/Feeds.dart';
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

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavState();
}

class _NavState extends State<NavPage> {
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
  }
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final formKey = GlobalKey<FormState>();
  UserModel profile = UserModel(uid: '', username: '', password: '', email: '',profileUrl: '' ,bio: '' ,rate: 0, succeedcount:0 );
  bool _showPassword = true;
  String? _Cpassword;
  int currentTap = 0;
  int currentAppbar = 0;
  final List<Widget> appbarTap = [
    MenuPage(),
  ];
  void _onAppbarTap(int index) {
    setState(() {
      currentAppbar = index;
    });
  }

  final List<Widget> screens = [
                          
    FeedsPage(), ProfilePage(), MessagePage()];

  void _onItemTap(int index) {
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
              appBar: AppBar(
                  //title: Text("test"),
                  backgroundColor:currentTap ==1 ?Color.fromRGBO(66, 194, 255, 1) :Color.fromRGBO(133, 244, 255, 1),

                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return NotiPage();
                      }));
                      },
                      icon: Icon((FontAwesomeIcons.bell)),
                    )
                  ],
                  leading: Padding(
                    padding: const EdgeInsets.all(0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return MenuPage();
                          }));
                        },
                        icon: Icon((FontAwesomeIcons.bars))),
                  )),
              // body: Center(child: screens.elementAt(currentTap)),
              // bottomNavigationBar: BottomNavigationBar(
              body: IndexedStack(
                index: currentTap,
                children: screens,),
                bottomNavigationBar: BottomNavigationBar(
                 showSelectedLabels: false,
                 showUnselectedLabels: false,
                backgroundColor: Color.fromRGBO(66, 194, 255, 1),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon((FontAwesomeIcons.home),
                          color:
                              currentTap == 0 ? Colors.white : Colors.black26),
                      label: "Feed"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        (FontAwesomeIcons.solidUser),
                        color: currentTap == 1 ? Colors.white : Colors.black26,
                      ),
                      label: "Profile"),
                  BottomNavigationBarItem(
                      icon: Icon((FontAwesomeIcons.solidMessage),
                          color:
                              currentTap == 2 ? Colors.white : Colors.black26),
                      label: "Chat"),
                ],
                currentIndex: currentTap,
                onTap: _onItemTap,
              ),
            );
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
