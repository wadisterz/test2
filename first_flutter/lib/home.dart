import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';




class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _image;
  Future getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("This is Appbar"),
        ),
        backgroundColor: Color.fromRGBO(133, 244, 255, 1),
        body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Column(
                  children: [
                    SizedBox(
                      child: ElevatedButton.icon(
                        
                        onPressed: (){
                            getImage();
                            print("getimage");
                          _image != null ? Image.file(
                            _image!):
                        }),
                    ),
                    SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: ElevatedButton(onPressed: (){
                          },
                          child: Text("Register")),
                        ),
                        SizedBox(width: 100,),
                        SizedBox(
                          child: ElevatedButton(onPressed: (){},
                          child: Text("Back")),
                        )
                      ],
                    ))
                  ],
                ))
              ],
            )));
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
