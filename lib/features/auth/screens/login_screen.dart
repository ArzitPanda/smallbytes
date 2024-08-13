import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/auth/screens/signup_screen.dart';
import 'package:smallbytes/features/auth/viewModels/auth_view_model.dart';
import 'package:smallbytes/features/auth/widget/input_login.dart';
import 'package:smallbytes/features/auth/widget/small_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image.asset("assets/images/login.png"),
                SizedBox(height: 10),
                Text(
                  "Log in",
                  style: TextStyle(fontSize: 25),
                ),
                Column(
                  children: [
                    Text("data")
                  ],
                ),
                Text(
                  "log in with social network",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallSocialButton(
                      location: 'assets/images/facebook-icon.png',
                      callback: () {},
                    ),
                    SizedBox(width: 10),
                    SmallSocialButton(
                        location: 'assets/images/instagram_icon.png',
                        callback: () {}),
                    SizedBox(width: 10),
                    SmallSocialButton(
                        location: 'assets/images/google.png', callback: () {}),
                  ],
                ),
                SizedBox(height: 20),
                LoginInput(hintText: "email", controller: _emailController),
                SizedBox(height: 10),
                LoginInput(hintText: "password", controller: _passwordController),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
                PrimaryButton(name: "Login", onPressed: ()async  {
                 await authViewModel.login(_emailController.text.trim(),_passwordController.text.trim() );
                }),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Sign up",
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
