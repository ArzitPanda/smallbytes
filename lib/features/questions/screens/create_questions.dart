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
  TextEditingController _questionCountController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create MCQ Set"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
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
              ),
              SizedBox(height: 20),
              PrimaryButton(
                name: "Proceed",
                onPressed: () {
                  int questionCount = int.parse(_questionCountController.text);
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
    );
  }
}

class QuestionPageView extends StatefulWidget {
  final int questionCount;
  final String questionSetName;

  QuestionPageView({required this.questionCount,required this.questionSetName});

  @override
  _QuestionPageViewState createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<QuestionPageView> {
  List<Question> questions = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
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
          title: Text("Add Questions"),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.questionCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Question ${index + 1}/${widget.questionCount}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    buildQuestionInput(context, index),
                    SizedBox(height: 20),
                    PrimaryButton(
                      name: "Save and Next",
                      onPressed: () {
                        if (index < widget.questionCount - 1) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        } else {
                          // Save the MCQ set and go back to the main screen
                       MCQSet  set =   MCQSet(name: widget.questionSetName, difficulty: "EASY", tags: ["tag1"], duration: 250, questions: questions);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmMcqScreen(set: set)));




                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildQuestionInput(BuildContext context, int questionIndex) {
    Question question = questions[questionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
          controller: TextEditingController(text: question.questionText),
          placeholder: "Enter your question",
          onChanged: (value) {
            question.questionText = value;
          },
        ),
        SizedBox(height: 10),
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
        SizedBox(height: 10),
        TextInput(
          controller: TextEditingController(text: question.hint),
          placeholder: "Hint (Optional)",
          onChanged: (value) {
            question.hint = value;
          },
        ),
        Divider(thickness: 2, color: Colors.grey[400]),
        SizedBox(height: 20),
      ],
    );
  }
}


