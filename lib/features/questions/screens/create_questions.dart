import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/course/widgets/input_widget.dart';
import 'package:smallbytes/features/questions/models/mcq_Set.dart';
import 'package:smallbytes/features/questions/models/question.dart';
import 'package:smallbytes/features/questions/screens/confirm_mcq_screen.dart';

class CreateMCQScreen extends StatefulWidget {
  @override
  _CreateMCQScreenState createState() => _CreateMCQScreenState();
}

class _CreateMCQScreenState extends State<CreateMCQScreen> {
  final TextEditingController _questionCountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create MCQ Set", style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.primary,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [CustomColors.primary.withOpacity(0.1), Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextInput(
                          controller: _nameController,
                          placeholder: "Enter your course name",
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: _questionCountController,
                          placeholder: "Enter the number of questions",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                PrimaryButton(
                  name: "Create MCQ Set",
                  onPressed: () {
                    if (_nameController.text.isEmpty || _questionCountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill in all fields")),
                      );
                      return;
                    }
                    int questionCount = int.tryParse(_questionCountController.text) ?? 0;
                    if (questionCount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid number of questions")),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionPageView(
                          questionCount: questionCount,
                          questionSetName: _nameController.text.trim(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionPageView extends StatefulWidget {
  final int questionCount;
  final String questionSetName;

  QuestionPageView({required this.questionCount, required this.questionSetName});

  @override
  _QuestionPageViewState createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<QuestionPageView> {
  List<Question> questions = [];
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    questions = List.generate(widget.questionCount, (index) {
      return Question(
        questionText: '',
        options: List.filled(4, ''),
        correctOption: 0,
        hint: '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Questions", style: TextStyle(color: Colors.white)),
          backgroundColor: CustomColors.primary,
          elevation: 0,
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: (currentPage + 1) / widget.questionCount,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primary),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.questionCount,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Question ${index + 1}/${widget.questionCount}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CustomColors.primary),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          buildQuestionInput(context, index),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage > 0)
                    ElevatedButton(
                      child: Text("Previous"),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(foregroundColor: CustomColors.primary),
                    ),
                  ElevatedButton(
                    child: Text(currentPage < widget.questionCount - 1 ? "Next" : "Finish"),
                    onPressed: () {
                      if (currentPage < widget.questionCount - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        MCQSet set = MCQSet(
                          name: widget.questionSetName,
                          difficulty: "EASY",
                          tags: ["tag1"],
                          duration: 250,
                          questions: questions,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmMcqScreen(set: set)));
                      }
                    },
                    style: ElevatedButton.styleFrom(foregroundColor: CustomColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionInput(BuildContext context, int questionIndex) {
    Question question = questions[questionIndex];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              controller: TextEditingController(text: question.questionText),
              placeholder: "Enter your question",
              onChanged: (value) {
                question.questionText = value;
              },
            ),
            SizedBox(height: 20),
            ...List.generate(4, (optionIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextInput(
                        controller: TextEditingController(text: question.options[optionIndex]),
                        placeholder: "Option ${optionIndex + 1}",
                        onChanged: (value) {
                          question.options[optionIndex] = value;
                        },
                      ),
                    ),
                    Radio<int>(
                      value: optionIndex,
                      groupValue: question.correctOption,
                      activeColor: CustomColors.primary,
                      onChanged: (value) {
                        setState(() {
                          question.correctOption = value!;
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 20),
            TextInput(
              controller: TextEditingController(text: question.hint),
              placeholder: "Hint (Optional)",
              onChanged: (value) {
                question.hint = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}