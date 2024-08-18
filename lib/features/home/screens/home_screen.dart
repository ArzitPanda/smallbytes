import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/services/user_service.dart';
import 'package:smallbytes/features/course/screen/course_screen.dart';
import 'package:smallbytes/features/profile/screen/profile_screen.dart';
import 'package:smallbytes/features/questions/screens/questions_screen.dart';
import 'package:smallbytes/features/settings/screen/setting_screen.dart';
import 'package:smallbytes/core/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  UserService service = UserService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    await service.loadUserModel();
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    // Show loader if userModel is null
    if (service.userModel == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: CustomColors.primary,
          ), // Show loader
        ),
      );
    }

    // Actual content when userModel is loaded
    List<Widget> tabs = [
      CourseScreen(userModel: service.userModel!),
      QuestionsScreen(userModel: service.userModel!,),
      ProfileScreen(userModel: service.userModel!),
      SettingScreen(userModel: service.userModel!),
    ];

    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: CustomColors.primary,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        index: index,
        height: 75,
        items: const <Widget>[
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.book, size: 30, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.queue_sharp, size: 30, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.person, size: 30, color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.settings, size: 30, color: Colors.white),
          ),
        ],
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
      ),
    );
  }
}
