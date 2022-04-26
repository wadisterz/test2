import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
                      child: ElevatedButton(
                          onPressed: () {},
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          )),
                    ),
                    SizedBox(
                        child: Row(
                      children: [
                        SizedBox(
                          child: ElevatedButton(onPressed: (){},
                          child: Text("Register")),
                        ),
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
