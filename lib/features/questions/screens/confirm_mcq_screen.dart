import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/services/questions_service.dart';

class ConfirmMcqScreen extends StatefulWidget {
  final MCQSet set;

  ConfirmMcqScreen({super.key, required this.set});

  @override
  State<ConfirmMcqScreen> createState() => _ConfirmMcqScreenState();
}

class _ConfirmMcqScreenState extends State<ConfirmMcqScreen> {
  
  QuestionsService _questionsService = QuestionsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm MCQ Set'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.set.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Difficulty: ${widget.set.difficulty}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Duration: ${widget.set.duration} minutes',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.set.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.set.questions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: question.options.map((option) {
                                final isCorrect = question.options.indexOf(option) == question.correctOption;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      color: isCorrect ? Colors.green : Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Hint: ${question.hint}',
                              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(
              name: "Publish the MCQ",
              onPressed: ()async {
                  try
                  {
                   await  _questionsService.addQuestionSet(widget.set);
                   Fluttertoast.showToast(
                     msg: "added Succesfully",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     timeInSecForIosWeb: 1,
                     backgroundColor: CustomColors.primary,
                     textColor: Colors.white,
                     fontSize: 16.0
                 );
                  }
                  catch(e)
                  {
                    Fluttertoast.showToast(
                     msg: e.toString(),
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     timeInSecForIosWeb: 1,
                     backgroundColor: Colors.white,
                     textColor: Colors.white,
                     fontSize: 16.0
                 );
                  }
              
                // Add your onPressed logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
