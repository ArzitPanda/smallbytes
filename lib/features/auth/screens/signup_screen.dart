import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/auth/screens/login_screen.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/auth/widget/input_login.dart';
import 'package:smallbytes/features/profileCreate/ProfileViewModel.dart';
import 'package:smallbytes/features/profileCreate/screen/profile_screen.dart';
import 'package:smallbytes/features/profileCreate/user_profile.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController =TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final profileModel = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset("assets/images/signup.png"),
                const SizedBox(height: 10),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                  "Create Your Account",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 20),
                LoginInput(hintText: "name", controller: _nameController),
                const SizedBox(height: 10),
                LoginInput(hintText: "email", controller: _emailController),
                const SizedBox(height: 10),
                LoginInput(hintText: "password", controller: _passwordController),
                const SizedBox(height: 20,),
                PrimaryButton(name: "Signup", onPressed: () async {
                  print("clicked");
                 try
                 {
                 User user = await authViewModel.signUp(_emailController.text.trim(), _passwordController.text.trim(), _nameController.text.trim());

                 profileModel.setUserProfile(UserProfile(name: user.name,email: user.email,uid: user.$id));



                 }
                 catch(r)
                  {
                    print(r);
                  }


                }),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProfileScreen()),
                    );

                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


