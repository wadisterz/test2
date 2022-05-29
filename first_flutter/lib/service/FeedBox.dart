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
  bool status;
  FeedBox(this.name, this.title, this.gps,this.status){
    print("this status = ${status}");
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: status == true ? Color.fromRGBO(192, 192, 192, 1): Color.fromRGBO(66, 194, 255, 1),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0.0, 5.0))
          ]),
      height: 120,
      width: 380,
      child: Container(
        child: Row(children: <Widget>[
          Container(
            child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    "https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg  ")),
          ),
          Padding(padding: EdgeInsets.only(left: 4)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Spacer(),
              Text(
                title!,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Spacer(),
              Text(
                gps!,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
