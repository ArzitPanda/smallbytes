import 'package:flutter/material.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/models/question.dart';

class MCQQuizScreen extends StatefulWidget {
  final MCQSet mcqSet;

  MCQQuizScreen({Key? key, required this.mcqSet}) : super(key: key);

  @override
  _MCQQuizScreenState createState() => _MCQQuizScreenState();
}

class _MCQQuizScreenState extends State<MCQQuizScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late List<int?> _userAnswers;
  late DateTime _quizStartTime;
  late int _secondsPerQuestion;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userAnswers = List.filled(widget.mcqSet.questions.length, null);
    _quizStartTime = DateTime.now();
    _secondsPerQuestion = (widget.mcqSet.duration  / widget.mcqSet.questions.length).round();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _submitAnswer(int questionIndex, int answerIndex) {
    setState(() {
      _userAnswers[questionIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentPage < widget.mcqSet.questions.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showResults();
    }
  }

  void _showResults() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.mcqSet.questions.length; i++) {
      if (_userAnswers[i] == widget.mcqSet.questions[i].correctOption) {
        correctAnswers++;
      }
    }
    double score = (correctAnswers / widget.mcqSet.questions.length) * 100;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your score: ${score.toStringAsFixed(2)}%'),
              Text('Correct answers: $correctAnswers / ${widget.mcqSet.questions.length}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mcqSet.name),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.mcqSet.questions.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return QuestionPage(
            question: widget.mcqSet.questions[index],
            questionIndex: index,
            totalQuestions: widget.mcqSet.questions.length,
            secondsPerQuestion: _secondsPerQuestion,
            onSubmit: _submitAnswer,
            onTimeUp: _nextQuestion,
            selectedAnswer: _userAnswers[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: _nextQuestion,
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  final Question question;
  final int questionIndex;
  final int totalQuestions;
  final int secondsPerQuestion;
  final Function(int, int) onSubmit;
  final VoidCallback onTimeUp;
  final int? selectedAnswer;

  QuestionPage({
    Key? key,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.secondsPerQuestion,
    required this.onSubmit,
    required this.onTimeUp,
    this.selectedAnswer,
  }) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late int _secondsLeft;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.secondsPerQuestion;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_secondsLeft > 0) {
            _secondsLeft--;
            _startTimer();
          } else {
            widget.onTimeUp();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${widget.questionIndex + 1} of ${widget.totalQuestions}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Time left: $_secondsLeft seconds'),
          SizedBox(height: 16),
          Text(
            widget.question.questionText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...widget.question.options.asMap().entries.map((entry) {
            int idx = entry.key;
            String option = entry.value;
            return RadioListTile<int>(
              title: Text(option),
              value: idx,
              groupValue: widget.selectedAnswer,
              onChanged: (int? value) {
                if (value != null) {
                  widget.onSubmit(widget.questionIndex, value);
                }
              },
            );
          }).toList(),
          SizedBox(height: 16),
          Text('Hint: ${widget.question.hint}'),
        ],
      ),
    );
  }
}