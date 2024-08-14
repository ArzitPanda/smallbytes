import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.black, width: 1)),
            child: Icon(
              Icons.arrow_back_ios,
              size: 10,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: const ShapeDecoration(
                  shape: 
                  CircleBorder(
                      side: 
                      BorderSide(
                        color: Colors.blueAccent, width: 4))),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/images/login.png'),
              ),
            ),
        SizedBox(height: 20,),
          Column(

            children: [
              GestureDetector(child: PrimaryWrapperWidget(primaryChild: Text("My Courses")),onTap: (){},),
              SizedBox(height: 20,),
               PrimaryWrapperWidget(primaryChild: Text("Saved")),
                SizedBox(height: 20,),
               PrimaryWrapperWidget(primaryChild: const Text("Payment")),
               SizedBox(height: 20,),
               TextButton(onPressed: (){}, child: Text("log out"))
                ,


        
            ],
          )
        
          ],
        ),
      ),
    );
  }
}
