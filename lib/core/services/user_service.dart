import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/core/constant/db_constant.dart';
import 'package:smallbytes/core/models/user_model.dart';

class UserService {
  UserModel? userModel;

  Databases database = Databases(AppwriteClient().client);

  Future<UserModel?> loadUserModel() async {
    try {
      print("hello");

      User? user = await Account(AppwriteClient().client).get();

      DocumentList documents = await database.listDocuments(
          databaseId: DB_ID,
          collectionId: USER_COLLECTION,
          queries: [Query.equal("uid", user.$id)]);

      print(documents.total);
      Map<String, dynamic> resultmap = documents.documents.first.data;
      documents.documents.first.data.forEach((key, value) {
        print("$key-->$value");
      });

       userModel = UserModel(
          id: resultmap["\$id"],
          name: user.name,
          email: user.email,
          uid: resultmap["uid"],
          bio: resultmap["bio"],
          profile_picture: resultmap["profile_picture"]);

      return userModel;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
