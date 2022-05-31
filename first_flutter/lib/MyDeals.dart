import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_flutter/Menu.dart';
import 'package:first_flutter/Model/DealModel.dart';
import 'package:first_flutter/Model/PostModel.dart';
import 'package:first_flutter/Model/UserModel.dart';
import 'package:first_flutter/Model/posttest.dart';
import 'package:first_flutter/Profile.dart';
import 'package:first_flutter/service/AddPostButton.dart';
import 'package:first_flutter/Nav.dart';
import 'package:first_flutter/Register.dart';
import 'package:first_flutter/main.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
import 'package:get/get.dart';
import 'package:geolocator_android/geolocator_android.dart';


class MyDeals extends StatefulWidget {
  const MyDeals({Key? key}) : super(key: key);

  @override
  State<MyDeals> createState() => _MyDealsState();
}

class _MyDealsState extends State<MyDeals> {

  @override
   void initState(){
     super.initState();
     print("init deals");
     readtest();
   }
  Position? _currentUserPosition;
  double? distanceKM = 0.0;

  List<Widget> widgets = [];
  Future _getDistance()async{
    bool serviceEnabled;
    LocationPermission permission;

serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  return Future.error('Location services are disabled');
}

permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    return Future.error('Location permissions are denied');
  }
}

if (permission == LocationPermission.deniedForever) {
  return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
}
  }
  final auth = FirebaseAuth.instance;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final userRef = FirebaseFirestore.instance.collection('user');
  Stream<List<UserModel>> readUser()=> FirebaseFirestore.instance.collection('user')
  .snapshots()
  .map((snapshot)=>snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
    int i = 0;
    bool refresh = true;
  Future<Null> readtest() async{
    await Firebase.initializeApp().then((value) async {
          final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
    final snapshot = await docUser.get();
          Map<String, dynamic> map = snapshot.data()!;
          print('map = $map');
          UserModel2 modelpost2 = UserModel2.fromMap(map);
      print("data initialize");
      await FirebaseFirestore.instance.collection('deal').where('postbyid',isEqualTo: uid ).snapshots().listen((event) async {
        if(refresh == true){
        for(var snapshots in event.docs){
          print('inloop = ${i}');
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          DealModel modeldeal = DealModel.fromMap(map);
          setState(() {
            widgets.add(createWidget(modeldeal,i,distanceKM!,modelpost2));
          print("done-----------------------------------------");
          });}
          print("widgets lengtt = ${widgets.length}");
          i++;
        }
        refresh = false;
      });
    });
  }
  
  Widget createWidget(DealModel model, int i , double diskm,UserModel2 modelpost2)=> 
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
                                 backgroundImage: AssetImage('images/default.png'),
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
                 Text("Takeby: ${model.takeby}",
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
                 Text(model.detail,
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
             child: model.succeed == false ?  Text("Deal",
             style: TextStyle(
                             fontSize: 25,
                             color: Colors.white,
                             fontWeight: FontWeight.bold),
             ):Text("CloseDeal",
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
                Navigator.of(context).pop();
                await docDeal.doc(model.dealid).update({
                  "succeed": true
                });
                

              },
             ),
           )

         ],
         
         
         
         
         );
         
         });
         print("objecct${i}");
         print("click post ${model.dealid}");
       },
       child: Container(
         height: 160,
         child: Column(
           children: [
              FeedBox(model.postby,model.heading,model.location,model.succeed),
           ],
         ),
       ),
     );
     
    

  Stream<List<PostModel?>> readPost()=> FirebaseFirestore.instance.collection('post')
  .snapshots()
  .map((snapshot)=>snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());
  Stream<List<PostModel>> readPostz()=> FirebaseFirestore.instance.collection('post').snapshots().map((snapshot)=>
  snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());




  
  
  // --------------
  Future<UserModel?> readUserz()async{
    final docUser = FirebaseFirestore.instance.collection('user').doc(uid);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return UserModel.fromJson(snapshot.data()!);
    }
  //if(snapshot.exists){
  //}
  }

    CollectionReference docPost= FirebaseFirestore.instance.collection('post');
    CollectionReference docDeal= FirebaseFirestore.instance.collection('deal');



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
                             postmodel.postby = user.username!;
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
  PostModel postmodel = PostModel(pid: "", uid: "", postby: "", heading: "", location: "", status: false, text: "", profileUrl: "",latitude: 0.0, longitude: 0.0);

  

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  Future<void> setPost(BuildContext context) async {
    print("insetpost");
  print( "uid in Feed = ${profile.uid}");
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
                  key: formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  "),
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
                           return Text("",
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
                    Divider(
                      color: Colors.white,
                      thickness: 0.4,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "",
                      prefixIcon: Icon(Icons.location_on ,color: Colors.white,)
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                          validator: RequiredValidator(
                            errorText: "enter"
                          ),
                      onSaved: (String? location ){
                        postmodel.location = location!;
                      },
                    ),
                    TextFormField(
                      controller: _con,
                      decoration: InputDecoration(hintText: "heading",
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      maxLength: 18,
                          validator: RequiredValidator(
                            errorText: "enter"
                          ),
                          onSaved: (String? heading){
                            postmodel.heading = heading!;
                          },
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
                          validator: RequiredValidator(
                            errorText: "enter"
                          ),
                          onSaved: (String? text){
                            postmodel.text = text!;
                          },
                          
                    ),
                    Divider(color: Colors.white,
                    thickness: 0.2,),
                  ]),
                 
                ),
              ),
              actions: <Widget>[
                Center(
                  child: ElevatedButton(
                    child: Text("OFFER",
                    style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    )
                    
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(11, 119, 170, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(10),
                        minimumSize: Size(150, 50)
                    ) ,
                    onPressed: () async {
                      // print("pid = ${postmodel.pid}");
                      // print("uid = ${postmodel.uid}");
                      // print("postby = ${postmodel.postby}");
                      // print("heading = ${postmodel.heading}");
                      // print("location = ${postmodel.location}");
                      print("status = ${postmodel.status}");
                      // print("text = ${postmodel.text}");
                      // print("profuleUrl = ${postmodel.text}");
                        formKey.currentState?.save();
                      Navigator.of(context).pop();
                      postmodel.pid = auth.currentUser?.uid;
                      postmodel.uid = auth.currentUser?.uid;
                      await docPost.add({
                        "uid": postmodel.uid,
                        "pid": postmodel.pid,
                        "postby": postmodel.postby,
                        "heading": postmodel.heading,
                        "location": postmodel.location,
                        "status": postmodel.status,
                        "text":  postmodel.text,
                        "profileUrl": postmodel.profileUrl,
                        "latitude": _currentUserPosition!.latitude,
                        "longitude": _currentUserPosition!.longitude
                      }).then((value) => docPost.doc(value.id).update({
                        "pid": value.id
                      }));
                      print("pid = ${postmodel.pid}");
                    },
                  ),
                )
              ],
            );
         // );
        });
  }

  final formKey = GlobalKey<FormState>();

  UserModel profile = UserModel(uid: '', username: '', password: '', email: '',profileUrl: '' ,bio: '' ,rate: 0, succeedcount:0 );
  UserModel2 profile2 = UserModel2(uid: '', username: '', password: '', email: '',profileUrl: '' ,bio: '' ,rate: 0, succeedcount:0 );
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
    print("infeedpage");
    _getDistance();
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
                            return MenuPage();
                          }));
                        }, icon: Icon((FontAwesomeIcons.arrowLeft))),
                  )),
                    body: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return Scaffold(
                          backgroundColor: Color.fromRGBO(133, 244, 255, 1),
                          body: widgets.length == 0 ? Center(child: CircularProgressIndicator(),):RefreshIndicator
                          (
                            onRefresh: readtest,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: widgets
                              )
                            ),
                        );
                      }
                    )
    );}
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}