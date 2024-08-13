import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smallbytes/features/auth/screens/login_screen.dart';
import 'package:smallbytes/features/intro/widget/intro_page_list.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  IntroPageList introPageList = IntroPageList();
  int page=0;
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages: introPageList.page,
        onChange: (idx){
          setState(() {
           page=idx;
          });
        },
        dotsDecorator: const DotsDecorator(activeColor: Colors.orange),
        globalFooter: GestureDetector(

          onTap:(){
            if(page==2)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            else
              {

              }
          },


          child: Container(
            height: 50,

            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                page==2?"finish":'next',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
        showDoneButton: false,
        showSkipButton: true,
        skip: Text("skip"),
        onSkip: () {},
        showNextButton: false,
        onDone: () {
          // On button pressed
        });
  }
}
