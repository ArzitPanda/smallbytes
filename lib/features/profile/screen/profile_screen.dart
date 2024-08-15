import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/course/screen/self_courses_screen.dart';

class ProfileScreen extends StatefulWidget {
  UserModel? userModel;


  ProfileScreen({super.key,required this.userModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthViewModel>(context);

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
                child: ClipOval(
                  child: Image.network(
                    widget.userModel!.profile_picture,
                    fit: BoxFit.cover, // This ensures the image covers the entire CircleAvatar
                    width: 120,
                    height: 120,
                  ),
                ),
              )
              ,
            ),
        SizedBox(height: 20,),
          Column(

            children: [
              GestureDetector(child: PrimaryWrapperWidget(primaryChild: Text("My Courses")),onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SelfCoursesScreen()));

              },),
              SizedBox(height: 20,),
               PrimaryWrapperWidget(primaryChild: Text("Saved")),
                SizedBox(height: 20,),
               PrimaryWrapperWidget(primaryChild: const Text("Payment")),
               SizedBox(height: 20,),
               TextButton(onPressed: (){

                 authProvider.logout();
                 Fluttertoast.showToast(
                     msg: "sucessfully log out",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     timeInSecForIosWeb: 1,
                     backgroundColor: CustomColors.primary,
                     textColor: Colors.white,
                     fontSize: 16.0
                 );
               }, child: Text("log out"))
                ,


        
            ],
          )
        
          ],
        ),
      ),
    );
  }
}
