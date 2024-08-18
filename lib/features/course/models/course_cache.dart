import 'package:smallbytes/features/course/models/course.dart';

class CourseCache {
  static final CourseCache _instance = CourseCache._internal();
  factory CourseCache() => _instance;
  CourseCache._internal();

  List<Course> cachedCourses = [];
  bool hasMore = true;
  int offset = 0;
}