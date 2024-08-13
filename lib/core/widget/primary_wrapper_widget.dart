import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';

class PrimaryWrapperWidget extends StatelessWidget {
 late Widget primaryChild;
  double? height;
  double? widthFactor;
   PrimaryWrapperWidget({super.key,required this.primaryChild,this.height,this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width*(widthFactor ?? 0.8),
              height:height ?? 72,
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
            );
  }
}