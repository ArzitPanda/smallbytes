// ignore: file_names
import 'package:smallbytes/features/questions/models/question.dart';

class MCQSet {
  String name;
  String difficulty;
  List<String> tags;
  double duration;

  List<Question> questions;

  MCQSet({
    required this.name,
    required this.difficulty,
    required this.tags,
    required this.duration,
    required this.questions,
  });
}