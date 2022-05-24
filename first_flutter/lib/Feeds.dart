import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:first_flutter/service/AddPostButton.dart';
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
  Future<void> setPost(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _con = TextEditingController();
          return 
          //Expanded(
             AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: Color.fromRGBO(47, 161, 215, 1),
              content: SingleChildScrollView(
                child: Form(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  "),
                    ),
                    Text(
                      "name",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.4,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "",
                      prefixIcon: Icon(FontAwesomeIcons.mapLocation ,color: Colors.white,)
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    TextFormField(
                      controller: _con,
                      decoration: InputDecoration(hintText: "title",
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      maxLength: 18,
                    ),
                    SizedBox(height: 1,),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(hintText: "More information",
                      //border: InputBorder.none,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                          
                    ),
                    Divider(color: Colors.white,
                    thickness: 0.2,),
                  ]),
                 
                ),
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    child: Text("test2"),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(11, 119, 170, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(150, 50)
                    ) ,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            );
         // );
        });
  }

  final formKey = GlobalKey<FormState>();

  Profile profile = Profile(uid: '', username: '', password: '', email: '');
  bool _showPassword = true;
  String? _Cpassword;
  int currentTap = 0;
  final List<Widget> screens = [ProfilePage()];

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
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                backgroundColor: Color.fromRGBO(66, 194, 255, 1),
                onPressed: () async {
                  setPost(context);
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
