import 'package:flutter/material.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/features/course/screen/single_course_screen.dart';

class PrimaryCard extends StatelessWidget {
 String imgurl;
 String length;
 String name;
 String description;
  VoidCallback onPressed;


 PrimaryCard(
     {super.key, required this.imgurl, required this.length, required this.name, required this.description, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){},
      child: PrimaryWrapperWidget(

          height: 300,
          widthFactor: 0.95,
          primaryChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.93,

                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 175,
                        width: MediaQuery.of(context).size.width * 0.90,
                        color: Colors.deepOrange.shade50,

                      ),
                      Center(
                        child: Image.network(
                          height: 150,
                          fit: BoxFit.cover,
                          imgurl,
                          width: MediaQuery.of(context).size.width * 0.80,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(length,style: TextStyle(fontSize: 14,color: Colors.grey),),
                    SizedBox(height: 2,),
                    Text(name,style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 2,),
                    Text(description,style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),),



                  ],
                ),
              )
            ],
          )),
    );
  }
}
