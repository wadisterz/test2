import 'package:flutter/material.dart';
class AddPostButton extends StatefulWidget {
  
  const AddPostButton({ Key? key }) : super(key: key);
  
  

  @override
  State<AddPostButton> createState() => _AddPostButtonState();
}

class _AddPostButtonState extends State<AddPostButton> {
  Future<void> setPost (BuildContext context) async{
    return await showDialog(context: context, builder: (context){
      final TextEditingController _con = TextEditingController();
      return AlertDialog(
        content: Form(child: 
        Column(children: [
          TextFormField(
            controller: _con,
            validator: (value){
              return value!.isNotEmpty ? null :"empty";
            },
            decoration: InputDecoration(hintText: "enter text"),
            )

        ])
        ,),
        actions: <Widget> [
          TextButton(child: Text("test2"),
          onPressed: (){
            Navigator.of(context).pop();

          },)
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}