import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  late String name;
  late VoidCallback onPressed;

  PrimaryButton({super.key,required this.name,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      onTap:onPressed,


      child: Container(
        height: 50,

        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
