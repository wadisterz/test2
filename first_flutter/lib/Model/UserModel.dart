class UserModel {
   String? uid;
  String? username ; 
  String? password;
  String? email;
  String? bio;
  String? profileUrl;
  int? rate = 0;
  int? succeedcount = 0;
  UserModel({required this.uid , required this.username,required this.password,required this.email,required this.bio, required this.profileUrl, required this.rate,  required this.succeedcount});
  Map<String , dynamic> toJson() =>{
    'uid' : uid,
    'username' : username,
    'password' : password,
    'email' : email,
    'bio' : bio,
    'ProfileUrl' : profileUrl,
    'rate' : rate,
    'succeed' : succeedcount,
  };
  static UserModel fromJson(Map<String, dynamic> json) =>UserModel(
    uid: json['uid'],
    username: json['username'],
    password: json['password'],
    email: json['email'],
    bio: json['bio'],
    profileUrl: json['ProfileUrl'],
    rate: json['rate'],
    succeedcount: json['succeed']
    
  );
  
  
}