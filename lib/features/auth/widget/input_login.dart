import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  late String hintText;
  late TextEditingController controller;

  LoginInput({super.key,required this.hintText,required this.controller});


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      child: Center(
        child: TextField(
          cursorColor: Colors.black87,
          controller: controller,


          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.black87, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                      color: Colors.black12, width: 0.8))),
        ),
      ),
    );
  }
}
