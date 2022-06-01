class PostModel {
  String? pid;
   String? uid;
   String? postby;
  String? heading ; 
  String? location;
  bool? status;
  String? text;
  String? profileUrl;
  final double latitude;
  final double longitude;
  PostModel({required this.pid,required this.uid ,required this.postby, required this.heading,required this.location,required this.status,required this.text, required this.profileUrl, required this.latitude, required this.longitude});
  Map<String , dynamic> toJson() =>{
    'pid' : pid,
    'uid' : uid,
    'postby' : postby,
    'heading' : heading,
    'location' : location,
    'status' : status,
    'text' : text,
    'ProfileUrl' : profileUrl,
  };
  static PostModel fromJson(Map<String, dynamic> json) =>PostModel(
    pid: json['pid'],
    uid: json['uid'],
    postby: json['postby'],
    heading: json['heading'],
    location: json['location'],
    status: json['status'],
    text: json['text'],
    profileUrl: json['profileUrl'],
    latitude: json['latitude'],
    longitude: json['longitude']
    
  );
 //int dealcount = 0 ;
  //String profileUrl ;
  //double rate;
  //String bio;
  //String dealcount; 
  
  
  
}