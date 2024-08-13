import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/cutom_card.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/core/widget/round_button.dart';
import 'package:smallbytes/features/auth/screens/signup_screen.dart';
import 'package:smallbytes/features/course/screen/single_course_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<String> tags = ["css", "UX", "swift", "UI", "hey", "hello", "one"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Arijit Panda",
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                RoundButton(
                    child: Icon(
                  Icons.notifications_active,
                  color: CustomColors.grey_border,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            PrimaryWrapperWidget(
                widthFactor: 0.95,
                height: 50,
                primaryChild: TextField(
                  decoration: InputDecoration(
                      suffix: Icon(
                        Icons.search_rounded,
                        color: Colors.black87,
                        size: 24,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Categories"),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 56,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: tags.map((ele) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Chip(
                            label: Text(
                              "#" + ele,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                            side: BorderSide(width: 0, color: Colors.transparent),
                          ),
                        );
                      }).toList()),
                )
              ],
            ),
            // cards are here
            Column(
              children: List.filled(5,"name").map((ele){
                return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: PrimaryCard(
                      imgurl:
                      "https://images.unsplash.com/photo-1518773553398-650c184e0bb3",
                      length: "30m",
                      name: "UI & UX",
                      description: "good course on ui and ux",
                      onPressed: (){
                        print("hello world");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingleCourseScreen()),
                        );
                      }),
                );

              }).toList(),
            )
          ],
                ),
              ),
        ));
  }
}
