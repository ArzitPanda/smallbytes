import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';

class CustomSettingContainer extends StatelessWidget {
  String primaryText;
  String? secondaryText;
  IconData leading;
  Widget trailWidget;
  String? tooltip;
  CustomSettingContainer(
      {super.key,
      required this.primaryText,
      this.secondaryText,
      required this.trailWidget,
      required this.leading,
      this.tooltip});

  @override
  Widget build(BuildContext context) {
    return PrimaryWrapperWidget(
        primaryChild: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                child: IconButton.filled(
                  iconSize: 10,
                  onPressed: () {},
                  style: ButtonStyle(),
                  icon: Icon(leading),
                  color: Colors.white,
                  splashColor: Colors.blue[300],
                  splashRadius: 10,
                  tooltip: tooltip,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    primaryText,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  if (secondaryText != null)
                    Text(
                      secondaryText ?? "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                ],
              )
            ],
          ),
         trailWidget
        ],
      ),
    ));
  }
}
