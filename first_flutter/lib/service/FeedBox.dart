import 'package:flutter/material.dart';

//                      Text(name,
//                          style: TextStyle(
//                              fontSize: 20,
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold)),
//                              SizedBox(height: 1,)
class FeedBox extends StatelessWidget {
  String title;
  String name;
  FeedBox(this.name, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(156, 0, 183, 255),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0.0, 5.0))
          ]),
      height: 120,
      width: 500,
        child: Container(
          color: Colors.white,
          width: 5.0,
          child: Column(
            children: [
              Row(
                children: [
                const FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?"),
                ),
              ),
                ],
              ),
              Row(children: [
                Padding(padding: EdgeInsets.only(left: 10 )),
                Expanded(child: Text("<1km"))
                
              ],)
            ],
          ),
        ),
      
    );
  }
}
