import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/core/constant/db_constant.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';

class QuestionsService {



final Databases database = Databases(AppwriteClient().client);



Future<void> addQuestionSet(MCQSet set) async 
{

  try {
     Document d= await database.createDocument(databaseId: DB_ID,
   collectionId: MCQ_SET,
    documentId: ID.unique(), 
    data: {
        'TAGS':set.tags,
        'duration':set.duration,
        'name':set.name,
        'questions':set.questions.map((ele){
          return {'question':ele.questionText,'options':ele.options,'correct_option':ele.correctOption,'hint':ele.hint};
        }).toList()
    });
    
  } on AppwriteException  catch(e) {
    
    print(e.message);
     throw AppwriteException();
  }

}





}