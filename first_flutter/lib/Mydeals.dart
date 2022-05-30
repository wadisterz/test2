import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_flutter/Model/UserModel.dart';
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
import 'Model/posttest.dart';
import 'service/FeedBox.dart';

class DealPage extends StatefulWidget {
   const DealPage({Key? key}) : super(key: key);

  @override
  State<DealPage> createState() => _DealState();
}

class _DealState extends State<DealPage> {
  @override
   void initState(){
     super.initState();
     print("initstats");
     readtest();
   }
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
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
  }int i =0;
  List<Widget> widgets =[];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Future<Null> readtest() async{
      print("in readtest deal");
    await Firebase.initializeApp().then((value) async {
      print("data initialize");
      await FirebaseFirestore.instance.collection('deal').snapshots().listen((event) async {
        for(var snapshots in event.docs){
          print('inloop = ${i}');
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          posttest modelpost = posttest.fromMap(map);
          setState(() {
            widgets.add(createWidget(modelpost,i));
          });}
          print("widgets lengtt = ${widgets.length}");
          i++;
      });});}
  Widget createWidget(posttest model, int i  )=> 
     GestureDetector(
       onTap: (){
         showDialog(context: context, builder: (BuildContext context){
           return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         backgroundColor: Color.fromRGBO(47, 161, 215, 1),
         content: SingleChildScrollView(
           child: Column(mainAxisSize:MainAxisSize.min,
           children: [
             CircleAvatar(
               radius: 35,
              backgroundImage: NetworkImage(
               "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  ")
             ),
             Column(
               children: [
                 Text(model.postby,
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
                 Text(model.heading,
                 style: TextStyle(
                                 fontSize: 25,
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold),
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                           ),
                 Wrap(
                   children: [
                    Icon(Icons.location_on,
                    color: Colors.white,),
                    Text(model.location,
                   style: TextStyle(
                                   fontSize: 25,
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold),
                               overflow: TextOverflow.ellipsis,
                               maxLines: 1,
                             ),]
                 ),
                Divider(
                      color: Colors.white,
                      thickness: 0.4,
                ),
                 Text(model.text,
                 style: TextStyle(
                                 fontSize: 25,
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold),
                           ),
                Divider(
                      color: Colors.white,
                      thickness: 0.4,
                ),
               ],
             )
           ],
         ),
         ),
         actions: <Widget>[
           Center(
             child: ElevatedButton(
             child: Text("chat",
             style: TextStyle(
                             fontSize: 25,
                             color: Colors.white,
                             fontWeight: FontWeight.bold),
             ),
             style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(11, 119, 170, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(1),
              minimumSize: Size(150, 50)
              ),
              onPressed: ()async {
              },
             ),
           )

         ],
         
         
         
         
         );
         
         });
         print("objecct${i}");
         print("click post ${model.pid}");
       },
       child: Container(
         height: 160,
         child: Column(
           children: [
              FeedBox(model.postby,model.heading,model.location,model.status),
           ],
         ),
       ),
     );

  @override
  Widget build(BuildContext context) {
    print("in deal");
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
                          body:  
                          ListView(
                              scrollDirection: Axis.vertical,
                              children: widgets
                          ),
                          );
                          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}