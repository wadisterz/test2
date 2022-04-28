import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

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
                    TextField(
                      style: TextStyle(height: 0.4),
                      decoration: InputDecoration(
                          hintText: 'username',
                          counterText: "",
                              border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(184, 255, 249, 100)),
                              borderRadius: 
                              BorderRadius.circular(14.0)
                              ),
                          fillColor: Color.fromRGBO(184, 255, 249, 100),
                          filled: true
                          ),
                          
                      maxLength: 20,
                    ),
                    TextField(
                      style: TextStyle(height: 0.4),
                      decoration: InputDecoration(
                          hintText: 'email',
                          counterText: "",
                              border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(184, 255, 249, 100)),
                              borderRadius: 
                              BorderRadius.circular(14.0)
                              ),
                          fillColor: Color.fromRGBO(184, 255, 249, 100),
                          filled: true
                          ),
                          
                      maxLength: 20,
                    ),
                    SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Register")),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Back")),
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
    return Scaffold();
  }
}
