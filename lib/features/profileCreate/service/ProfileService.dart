import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:smallbytes/features/profileCreate/user_profile.dart';


class ProfileService {
  final Client client;
  final Storage storage;
  final Databases database;
  final String bucketId = '66b7249e0031729fcacb';
  final String collectionId = '66b71aa60032a31ee6de';
  final String databaseId ='66b71a8c0008259aa23a';

  ProfileService(this.client)
      : storage = Storage(client),
        database = Databases(client);

  Future<String> uploadProfilePicture(String filePath,String fileName,String filetype) async {
    final file = await storage.createFile(
      bucketId: bucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: filePath,contentType: filetype,filename: fileName),
    );

    return file.$id;
  }

  Future<void> createProfile(UserProfile profile) async {
    try
        {
        Document d=  await database.createDocument(
            collectionId: collectionId,
            documentId: ID.unique(),

            data: {
              'user_email': profile.email,
              'bio': profile.bio,
              'uid': profile.uid,
              'user_type': profile.userType,
              'tags': ["java"],
            }, databaseId: databaseId,
          );

        print(d.$id);
        }
        catch(error)
    {
      print(error);
    }
  }
}
