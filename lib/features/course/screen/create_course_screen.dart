import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/features/course/models/course.dart';
import 'package:smallbytes/features/course/service/course_service.dart';
import 'package:smallbytes/features/course/widgets/input_widget.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  TextEditingController _courseNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  List<String> content = List.empty(growable: true);
  List<String> urls = List.empty(growable: true);
  List<String> selectedTags = List.empty(growable: true);
  String difficulty = 'Easy';
  bool isPublished = false;

  final List<String> tags = List.generate(30, (index) => 'Tag ${index + 1}');
  final List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];


  CourseService courseService = CourseService();

  void addToCourse()async
  {
    Course c= Course(name: _courseNameController.text, description: _descriptionController.text, tags: tags, isPublished: isPublished, content: content, contentUrls: urls, level: "BEGINNER",
        createdAt: DateTime.now(), userCourseCreatorId: "66baf26753408901adcf");


  courseService.createDocument(c);


  }



  void showAddContentDialog(BuildContext context, {bool isURL = false}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isURL ? "Add URL" : "Add Content",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: isURL ? _urlController : _contentController,
                decoration: InputDecoration(labelText: isURL ? 'Enter URL' : 'Enter content'),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      if (isURL) {
                        urls.add(value);
                      } else {
                        content.add(value);
                      }
                    });
                    Navigator.of(context).pop(); // Close the BottomSheet
                  }
                },
              ),
              SizedBox(height: 10),
              PrimaryButton(
                name: "Add ${isURL ? 'URL' : 'Content'}",
                onPressed: () {
                  final String value = isURL ? _urlController.text : _contentController.text;
                  if (value.isNotEmpty) {
                    setState(() {
                      if (isURL) {
                        urls.add(value);
                      } else {
                        content.add(value);
                      }
                    });
                    Navigator.of(context).pop(); // Close the BottomSheet
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create a course"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInput(controller: _courseNameController, placeholder: "Course Name"),
                SizedBox(height: 30),
                TextInput(controller: _descriptionController, placeholder: "Description"),
                SizedBox(height: 30),
                if (content.isEmpty)
                  GestureDetector(
                    onTap: () {
                      showAddContentDialog(context);
                    },
                    child: PrimaryWrapperWidget(
                      primaryChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: CustomColors.primary),
                          SizedBox(width: 5),
                          Text("Click here to add content"),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Text("Content added: ${content.join(", ")}"),
                      SizedBox(height: 10),
                      PrimaryButton(
                        name: "Add another content",
                        onPressed: () {
                          showAddContentDialog(context);
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (urls.isEmpty)
                  GestureDetector(
                    onTap: () {
                      showAddContentDialog(context, isURL: true);
                    },
                    child: PrimaryWrapperWidget(
                      primaryChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.link, color: CustomColors.primary),
                          SizedBox(width: 5),
                          Text("Click here to add URLs"),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Text("URLs added: ${urls.join(", ")}"),
                      SizedBox(height: 10),
                      PrimaryButton(
                        name: "Add another URL",
                        onPressed: () {
                          showAddContentDialog(context, isURL: true);
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Select Difficulty",
                    border: OutlineInputBorder(),
                  ),
                  value: difficulty,
                  items: difficultyLevels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      difficulty = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: tags.map((tag) {
                    bool isSelected = selectedTags.contains(tag);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected ? selectedTags.remove(tag) : selectedTags.add(tag);
                        });
                      },
                      child: Chip(
                        label: Text(tag),
                        backgroundColor: isSelected ? CustomColors.primary : Colors.grey[300],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Want to publish now?",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: isPublished,
                      activeTrackColor: CustomColors.primary,
                      onChanged: (value) {
                        setState(() {
                          isPublished = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                PrimaryButton(
                  name: "Save Course",
                  onPressed: addToCourse,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
