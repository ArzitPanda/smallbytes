class Question {
  String questionText;
  List<String> options;
  int correctOption;
  String hint;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
    required this.hint,
  });
}