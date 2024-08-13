import 'package:flutter/material.dart';
import 'package:smallbytes/core/widget/round_button.dart';

class SingleCourseScreen extends StatefulWidget {
  const SingleCourseScreen({super.key});

  @override
  State<SingleCourseScreen> createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              RoundButton(child: Icon(Icons.chevron_left),)
            ],
          )
        ],
      ),
    );
  }
}
