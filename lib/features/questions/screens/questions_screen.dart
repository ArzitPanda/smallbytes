import 'package:flutter/material.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/screens/start_now_screen.dart';
import 'package:smallbytes/features/questions/services/questions_service.dart';

class QuestionsScreen extends StatefulWidget {
  final UserModel? userModel;
  QuestionsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final QuestionsService _questionsService = QuestionsService();
  List<MCQSet> _mcqSets = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<MCQSet> loadedSets = await _questionsService.getQuestions();
      setState(() {
        _mcqSets = loadedSets;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading questions: $e');
      setState(() {
        _isLoading = false;
      });
      // You might want to show an error message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MCQ Sets'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadQuestions,
        child: ListView.builder(
          itemCount: _mcqSets.length,
          itemBuilder: (context, index) {
            MCQSet mcqSet = _mcqSets[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(mcqSet.name),
                subtitle: Text(mcqSet.tags.join(', ')),
                trailing: Text('${mcqSet.questions.length} questions'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartNowScreen(mcqSet: mcqSet),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}