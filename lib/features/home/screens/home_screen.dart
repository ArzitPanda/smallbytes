import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/features/course/screen/course_screen.dart';
import 'package:smallbytes/features/profile/screen/profile_screen.dart';
import 'package:smallbytes/features/settings/screen/setting_screen.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index=1;


  @override
  Widget build(BuildContext context) {
      List<Widget> tabs=[
    const CourseScreen(),
    ProfileScreen(),
    const SettingScreen()

  ];
    return Scaffold(
     body: tabs[index],

      bottomNavigationBar:CurvedNavigationBar(
        color: CustomColors.primary,
    backgroundColor: Colors.white,
    animationCurve: Curves.ease,
index: index,
    height: 75,
    items: const <Widget>[
     Padding(
        padding: EdgeInsets.all(8.0),
        child:Icon(Icons.book, size: 30,color: Colors.white,),
      ),
     Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.person, size: 30,color: Colors.white),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.settings, size: 30,color: Colors.white),
      ),
    ],
    onTap: (idx) {
      print(idx);
      setState(() {
        index=idx;
      });
    },
  ),
    );
  }
}
