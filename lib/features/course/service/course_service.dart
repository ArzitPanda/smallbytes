import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/constant/db_constant.dart';
import 'package:smallbytes/core/services/user_service.dart';
import 'package:smallbytes/features/course/models/course.dart';

class CourseService {
  static AppwriteClient client = AppwriteClient();

  final Databases database;

  CourseService() : database = Databases(client.client);

  void createDocument(Course course) async {
    try {
      Document d = await database.createDocument(
        databaseId: '66b71a8c0008259aa23a',
        collectionId: COURSE_COLLECTION,
        documentId: ID.unique(),
        data: {
          'name': course.name,
          'description': course.description,
          'tags': course.tags,
          'isPublished': course.isPublished,
          'content': course.content,
          'created_at': DateTime.now().toString(),
          'content_urls': course.contentUrls,
          'user_course_creator': UserService().userModelStatic!.id
        },
      );
      print(d.data);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<Course>> getCourses({int limit = 10, int offset = 0}) async {
    try {
      final result = await database.listDocuments(
        databaseId: '66b71a8c0008259aa23a',
        collectionId: COURSE_COLLECTION,
        queries: [
          Query.limit(limit),
          Query.offset(offset),
          Query.equal('isPublished', true),
          Query.orderDesc('created_at'),
        ],
      );
print(result.documents.length);

      
      return result.documents.map((doc) => Course.fromJson(doc.data)).toList();
    } catch (error) {
      print('Error fetching courses: ${error.toString()}');
      return [];
    }
  }
}