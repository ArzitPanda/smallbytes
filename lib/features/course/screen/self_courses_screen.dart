import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/course/screen/create_course_screen.dart';
import 'package:smallbytes/features/questions/screens/create_questions.dart';

class SelfCoursesScreen extends StatefulWidget {
  UserModel? userModel;

  SelfCoursesScreen({super.key,required this.userModel});

  @override
  State<SelfCoursesScreen> createState() => _SelfCoursesScreenState();
}

class _SelfCoursesScreenState extends State<SelfCoursesScreen> {
  void _showCreateOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
         backgroundColor: Colors.grey,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),

            height:MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width*0.6,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Choose an Option",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    )),
                PrimaryButton(name: "create a course", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCourseScreen()));

                }),
                SizedBox(height: 2,),
                PrimaryButton(name: "create a mcqset", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateMCQScreen()));

                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("My Courses"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a course",
        backgroundColor: CustomColors.primary,
        onPressed: _showCreateOptionsDialog,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body:  Center(
        child: Text(widget.userModel!.id ?? "loading.."),
      ),
    );
  }
}
