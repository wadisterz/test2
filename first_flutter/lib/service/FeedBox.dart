import 'package:flutter/material.dart';

//                      Text(name,
//                          style: TextStyle(
//                              fontSize: 20,
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold)),
//                              SizedBox(height: 1,)
class FeedBox extends StatelessWidget {
  String? title = "title";
  String? name = "name";
  String? gps = "gps";
  FeedBox(this.name, this.title,this.gps);

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.all(15.0),
     decoration: BoxDecoration(
       
                color: Color.fromRGBO(66, 194, 255, 1),
         borderRadius: BorderRadius.circular(35),
         boxShadow: [
           BoxShadow(
               color: Colors.black.withOpacity(0.2),
               spreadRadius: 1,
               blurRadius: 4,
               offset: Offset(0.0, 5.0))
         ]
         
         ),
     height: 120,
     width: 380,
      child: Container(
        child: Row(
          
          children:
           <Widget>[
          Container(
            
            child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage("https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  ")),
          ),
          Padding(padding: EdgeInsets.only(left: 4)),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
                      Text(name!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              ),
                              Spacer(),
                      Text(title!,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              ),
                              Spacer(),
                      Text(gps!,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              ),
          ],
          )),
//        Container(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(left: 8.0),
//              child: Container(
//                alignment: Alignment.center,
//                color: Colors.greenAccent,
//                child: 
//                    Row(
//                      children: [
//                        Text(name,
//                            style: TextStyle(
//                                fontSize: 20,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold)
//                                ),
//                      ],
//                    ),
//                    
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(left: 8.0),
//              child: Container(
//                child: Row(
//                  
//                  children: [
//                        Text(title,
//                            style: TextStyle(
//                                fontSize: 30,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                ),
//                  
//                ]),
//              ),
//            )
//          ]
//          ),
//        ),
        ]
        
        
        ),
        

      ),
      
    );
  }
}
