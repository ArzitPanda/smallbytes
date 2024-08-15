import 'dart:convert';

class Course {
  String name;
  String description;
  List<String> tags;
  bool isPublished;
  List<String> content;
  List<String> contentUrls;
  String level;
  DateTime createdAt;
  List<String>? courseTakerId;
  String userCourseCreatorId;

  Course({
    required this.name,
    required this.description,
    required this.tags,
    required this.isPublished,
    required this.content,
    required this.contentUrls,
    required this.level,
    required this.createdAt,
    this.courseTakerId,
    required this.userCourseCreatorId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "tags": jsonEncode(this.tags),
      "isPublished": this.isPublished,
      "content": jsonEncode(this.content),
      "contentUrls": jsonEncode(this.contentUrls),
      "level": this.level,
      "createdAt": this.createdAt.toIso8601String(),
      "courseTakerId": jsonEncode(this.courseTakerId),
      "userCourseCreatorId": this.userCourseCreatorId,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json["name"],
      description: json["description"],
      tags: List<String>.from(jsonDecode(json["tags"])),
      isPublished: json["isPublished"],
      content: List<String>.from(jsonDecode(json["content"])),
      contentUrls: List<String>.from(jsonDecode(json["contentUrls"])),
      level: json["level"],
      createdAt: DateTime.parse(json["createdAt"]),
      courseTakerId: json["courseTakerId"] != null
          ? List<String>.from(jsonDecode(json["courseTakerId"]))
          : null,
      userCourseCreatorId: json["userCourseCreatorId"],
    );
  }
}
