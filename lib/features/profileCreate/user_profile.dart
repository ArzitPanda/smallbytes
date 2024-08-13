import 'dart:convert';

class UserProfile {
   String email;
   String name;

  Map<String, dynamic> toJson() {
    return {
      "name":this.name,
      "email": this.email,
      "bio": this.bio,
      "uid": this.uid,
      "profilePictureUrl": this.profilePictureUrl,
      "userType": this.userType,
      "tags": jsonEncode(this.tags),
      "courses": jsonEncode(this.courses),
    };
  }


  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name:json["name"],
      email: json["email"],
      bio: json["bio"],
      uid: json["uid"],
      profilePictureUrl: json["profilePictureUrl"],
      userType: json["userType"],
      tags: List<String>.from(json["tags"] ?? []),
      courses: List<String>.from(json["Courses"] ?? []),
    );
  }

  late String bio;
  late String uid;
 late  String profilePictureUrl;
 late  String userType;
 late  List<String> tags;
 late  List<String> courses=List.empty();
   UserProfile({
     this.name = "",
     this.email = '',
     this.bio = '',
     this.uid = '',
     this.profilePictureUrl = '',
     this.userType = 'User',
     List<String>? tags,
     List<String>? courses,
   })  : tags = tags ?? [],
         courses = courses ?? [];


}
