import 'package:flutter/material.dart';

class SmallSocialButton extends StatelessWidget {

  String location;
  VoidCallback  callback;
  SmallSocialButton({super.key,required this.location,required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.blueAccent),
        child: Image.asset(location,height: 20,),
      ),
    );
  }
}
