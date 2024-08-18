import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:smallbytes/config/appwrite_client.dart';
import 'package:smallbytes/core/constant/db_constant.dart';
import 'package:smallbytes/core/services/user_service.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/models/question.dart';

class QuestionsService {





final Databases database = Databases(AppwriteClient().client);



Future<void> addQuestionSet(MCQSet set) async 
{

  String id =UserService().userModelStatic!.id;


  try {
     Document d= await database.createDocument(databaseId: DB_ID,
   collectionId: MCQ_SET,
    documentId: ID.unique(), 
    data: {
        'TAGS':set.tags,
        'duration':set.duration,
        'name':set.name,
      'user':id,
        'questions':set.questions.map((ele){
          return {'question':ele.questionText,'options':ele.options,'correct_option':ele.correctOption,'hint':ele.hint};
        }).toList()
    });
    
  } on AppwriteException  catch(e) {
    
    print(e.message);
     throw AppwriteException();
  }

}




Future<List<MCQSet>> getQuestions({int limit = 10, int offset = 0}) async {
  try {
    DocumentList response = await database.listDocuments(
      databaseId: DB_ID,
      collectionId: MCQ_SET,
      queries: [
        Query.limit(limit),
        Query.offset(offset),
      ],
    );

    List<MCQSet> mcqSets = response.documents.map((doc) {
      List<dynamic> questionsData = doc.data['questions'] as List<dynamic>;
      List<Question> questions = questionsData.map((q) {
        return Question(
          questionText: q['question'] as String,
          options: (q['options'] as List<dynamic>).map((option) => option.toString()).toList(),
          correctOption: q['correct_option'] as int,
          hint: q['hint'] as String,
        );
      }).toList();

      return MCQSet(
        name: doc.data['name'] as String,
        difficulty: doc.data['difficulty'] as String,
        tags: (doc.data['TAGS'] as List<dynamic>).map((tag) => tag.toString()).toList(),
        duration: (doc.data['duration'] as num).toDouble(),
        questions: questions,
      );
    }).toList();

    return mcqSets;
  } on AppwriteException catch (e) {
    print(e.message);
    throw AppwriteException();
  }
}





}