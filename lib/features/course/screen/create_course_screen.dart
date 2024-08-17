import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/features/course/models/course.dart';
import 'package:smallbytes/features/course/service/course_service.dart';
import 'package:smallbytes/features/course/widgets/input_widget.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<String> content = [];
  final List<String> urls = [];
  final List<String> selectedTags = [];
  String difficulty = '';
  bool isPublished = false;

  final List<String> tags = [
    'Programming', 'Design', 'Marketing', 'Business', 'Data Science',
    'AI', 'Machine Learning', 'Web Development', 'Mobile Development',
    'Cloud Computing', 'DevOps', 'Cybersecurity', 'Blockchain',
    'IoT', 'AR/VR', 'UX/UI', 'Project Management', 'Agile', 'Leadership',
    'Communication'
  ];
  final List<String> difficultyLevels = ['Beginner', 'Intermediate', 'Advanced'];

  final CourseService courseService = CourseService();

  void addToCourse() async {
    if (_courseNameController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    Course c = Course(
      name: _courseNameController.text,
      description: _descriptionController.text,
      tags: selectedTags,
      isPublished: isPublished,
      content: content,
      contentUrls: urls,
      level: difficulty.toUpperCase(),
      createdAt: DateTime.now(),
      userCourseCreatorId: "",
    );

    try {
      courseService.createDocument(c);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course created successfully')),
      );
      Navigator.of(context).pop(); // Return to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create course. Please try again.')),
      );
    }
  }

  void showAddContentDialog(BuildContext context, {bool isURL = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isURL ? "Add URL" : "Add Content",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: isURL ? _urlController : _contentController,
                  decoration: InputDecoration(
                    labelText: isURL ? 'Enter URL' : 'Enter content',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: isURL ? 1 : 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: Text("Add ${isURL ? 'URL' : 'Content'}"),
                  onPressed: () {
                    final String value = isURL ? _urlController.text : _contentController.text;
                    if (value.isNotEmpty) {
                      setState(() {
                        if (isURL) {
                          urls.add(value);
                          _urlController.clear();
                        } else {
                          content.add(value);
                          _contentController.clear();
                        }
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
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
          title: const Text("Create a Course"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextInput(controller: _courseNameController, placeholder: "Course Name"),
                const SizedBox(height: 16),
                TextInput(
                  controller: _descriptionController,
                  placeholder: "Description",
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                _buildSectionTitle("Course Content"),
                const SizedBox(height: 8),
                _buildContentSection(),
                const SizedBox(height: 24),
                _buildSectionTitle("Additional Resources"),
                const SizedBox(height: 8),
                _buildURLSection(),
                const SizedBox(height: 24),
                _buildSectionTitle("Course Details"),
                const SizedBox(height: 16),
                _buildTagsSection(),
                const SizedBox(height: 24),
                _buildPublishToggle(),
                const SizedBox(height: 32),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (content.isEmpty)
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Content"),
            onPressed: () => showAddContentDialog(context),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...content.asMap().entries.map((entry) {
                int idx = entry.key;
                String item = entry.value;
                return Card(
                  child: ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          content.removeAt(idx);
                        });
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add More Content"),
                onPressed: () => showAddContentDialog(context),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildURLSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (urls.isEmpty)
          ElevatedButton.icon(
            icon: const Icon(Icons.link),
            label: const Text("Add URL"),
            onPressed: () => showAddContentDialog(context, isURL: true),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...urls.asMap().entries.map((entry) {
                int idx = entry.key;
                String url = entry.value;
                return Card(
                  child: ListTile(
                    title: Text(url),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          urls.removeAt(idx);
                        });
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.link),
                label: const Text("Add More URLs"),
                onPressed: () => showAddContentDialog(context, isURL: true),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDifficultyDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
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
    );
  }

  Widget _buildTagsSection() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags.map((tag) {
        bool isSelected = selectedTags.contains(tag);
        return FilterChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedTags.add(tag);
              } else {
                selectedTags.remove(tag);
              }
            });
          },
          backgroundColor: Colors.grey[200],
          selectedColor: CustomColors.primary.withOpacity(0.2),
          checkmarkColor: CustomColors.primary,
        );
      }).toList(),
    );
  }

  Widget _buildPublishToggle() {
    return SwitchListTile(
      title: const Text(
        "Publish Course",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      value: isPublished,
      activeColor: CustomColors.primary,
      onChanged: (value) {
        setState(() {
          isPublished = value;
        });
      },
    );
  }
}