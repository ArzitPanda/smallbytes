import 'package:flutter/material.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/core/widget/round_button.dart';

class SingleCourseScreen extends StatefulWidget {
  const SingleCourseScreen({super.key});

  @override
  State<SingleCourseScreen> createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        child: PrimaryButton(name: "add to cart", onPressed: () {}),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("html"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: RoundButton(
              child: Icon(Icons.chevron_left),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/Cool_Kids_Bust.png",
              width: MediaQuery.of(context).size.width * 0.8,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Chip(
                  label: Text(
                    "price",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  side: BorderSide(width: 0, color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "About the course",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Text(
              "fghjk/nfghjk/n",
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
