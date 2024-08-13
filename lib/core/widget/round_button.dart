import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';

class RoundButton extends StatelessWidget {
  Widget child;
 RoundButton({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: CustomColors.grey_border, width: 1)),
      child: Center(
        child: child,
      ),
    );
  }
}
