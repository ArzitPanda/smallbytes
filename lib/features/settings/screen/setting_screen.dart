import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/widget/primary_wrapper_widget.dart';
import 'package:smallbytes/features/settings/widget/custom_setting_container.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.black, width: 1)),
            child: Icon(
              Icons.arrow_back_ios,
              size: 10,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/Cool_Kids_Bust.png'),
              SizedBox(
                height: 20,
              ),
              CustomSettingContainer(
                  primaryText: "Notifications",
                  trailWidget: Switch(
                      inactiveThumbColor: CustomColors.primary,
                      trackOutlineColor:
                          WidgetStatePropertyAll(CustomColors.grey_border),
                      trackColor: WidgetStatePropertyAll(Colors.white),
                      value: false,
                      onChanged: (value) {}),
                  leading: Icons.notifications),
        
              Container(
                width: MediaQuery.of(context).size.width*.8,
                height: 54,
                
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Account Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),textAlign: TextAlign.left,),
                )),
        
        
              Column(
                children: [
                  CustomSettingContainer(primaryText: "Name", secondaryText: "juana Antoleia",
                  trailWidget:Icon(Icons.chevron_right),
                  tooltip: "username"
                  
                  
                   , leading: Icons.person_4),
                  SizedBox(
                    height: 20,
                  ),
                   CustomSettingContainer(primaryText: "email", secondaryText: "j@gmmmmail.com",
                  trailWidget:Icon(Icons.chevron_right),
                  tooltip: "email"
                  
                  
                   , leading: Icons.person_4),
                  const SizedBox(
                    height: 20,
                  ),
                   CustomSettingContainer(primaryText: "Password", secondaryText: "update 2 weeks ago",
                  trailWidget:const Icon(Icons.chevron_right),
                  tooltip: "password"
                   , leading: Icons.lock),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
