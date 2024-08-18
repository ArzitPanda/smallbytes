import 'package:flutter/material.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/screens/mcq_quiz_screen.dart';

class StartNowScreen extends StatelessWidget {
  final MCQSet mcqSet;

  StartNowScreen({Key? key, required this.mcqSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Details'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mcqSet.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              _buildInfoRow(Icons.speed, 'Difficulty', mcqSet.difficulty),
              _buildInfoRow(Icons.question_answer, 'Questions', '${mcqSet.questions.length}'),
              _buildInfoRow(Icons.timer, 'Duration', '${mcqSet.duration} minutes'),
              SizedBox(height: 24),
              Text(
                'Tags',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildTagsRow(mcqSet.tags),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MCQQuizScreen(mcqSet: mcqSet),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Text(
                      'Start Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsRow(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => Chip(
        label: Text(tag),
        backgroundColor: Colors.grey[200],
      )).toList(),
    );
  }
}