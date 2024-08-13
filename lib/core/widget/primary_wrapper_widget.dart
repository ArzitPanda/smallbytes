import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';

class PrimaryWrapperWidget extends StatelessWidget {
 late Widget primaryChild;
   PrimaryWrapperWidget({super.key,required this.primaryChild});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.grey_border,
                    width: 1
                  ),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: primaryChild,
                ),
              ),
    );
  }
}