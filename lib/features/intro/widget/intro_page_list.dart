import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:introduction_screen/introduction_screen.dart';

class IntroPageList {
  List<Map<String, String>> maps = [
    {
      "title": "Learn  anytime\nand everywhere ",
      "desc":
          "Quarantine is the perfect time to spend your \n day learning something new, from anywhere!",
      "assets": "assets/images/screen_one.png"
    },
    {
      "title": "Fina a Course\nFor you",
      "desc":
          "Quarantine is the perfect time to spend your \nday learning something new, from anywhere!",
      "assets": "assets/images/screen_two.png"
    },
    {
      "title": "Improve your skills",
      "desc":
          "Quarantine is the perfect time to spend your \n day learning something new, from anywhere!",
      "assets": "assets/images/screen_three.png"
    }
  ];
  late List<PageViewModel> page;
  IntroPageList() {
    page = maps
        .map(
          (ele) => PageViewModel(
            titleWidget: Text(
              ele['title']!,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            bodyWidget: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ele['desc']!,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            image: Image.asset(
              ele['assets']!,
              fit: BoxFit.contain,
            ),
          ),
        )
        .toList();
  }
}
