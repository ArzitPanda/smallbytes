import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/core/widget/round_button.dart';
import 'package:smallbytes/features/course/models/course.dart';
import 'package:smallbytes/features/course/services/payment_service.dart';

import 'package:url_launcher/url_launcher.dart';



class SingleCourseScreen extends StatefulWidget {
  final Course course;

  SingleCourseScreen({Key? key, required this.course}) : super(key: key);

  @override
  State<SingleCourseScreen> createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  late PaymentService _paymentService;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService();
  }

  void _startPayment() {
    _paymentService.startPayment(
      key: 'YOUR_RAZORPAY_KEY',
      amount: (500 * 100).toInt(),
      name: widget.course.name,
      description: widget.course.description,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  void dispose() {
    _paymentService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.course.name,
          style: TextStyle(color: CustomColors.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: RoundButton(
              child: Icon(Icons.chevron_left, color: CustomColors.primary),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
        iconTheme: IconThemeData(color: CustomColors.primary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/images/Cool_Kids_Bust.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.course.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: CustomColors.primary),
                        ),
                      ),
                      Chip(
                        label: Text(
                          "\$${500}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: CustomColors.primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "About the course",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.course.description,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Course Level",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.course.level,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Tags",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.course.tags.map((tag) => Chip(
                      label: Text(tag),
                      backgroundColor: CustomColors.grey_border,
                    )).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Course Content",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.course.content.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.article, color: CustomColors.primary),
                        title: Text(widget.course.content[index]),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Additional Resources",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.course.contentUrls.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.link, color: CustomColors.primary),
                        title: Text(widget.course.contentUrls[index]),
                        onTap: () => _launchURL(widget.course.contentUrls[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: PrimaryButton(
          name: "Enroll Now",
          onPressed: _startPayment,

        ),
      ),
    );
  }
}