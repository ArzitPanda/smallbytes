import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallbytes/core/widget/primary_button.dart';
import 'package:smallbytes/features/profileCreate/ProfileViewModel.dart';

class ProfileCreateScreen extends StatefulWidget {
  ProfileCreateScreen({super.key});

  @override
  State<ProfileCreateScreen> createState() => _ProfileCreateScreenState();
}

class _ProfileCreateScreenState extends State<ProfileCreateScreen> {
  late TextEditingController _bioController;
  List<String> userTypes = ["TEACHER", "STUDENT"];
  List<String> availableTags = ["JAVA", "PYTHON", "C++", "FLUTTER", "REACT"];

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<ProfileViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${viewModel.userProfile?.name.isEmpty ?? true ? 'User' : viewModel.userProfile!.name}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _bioController,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        labelStyle: TextStyle(color: Colors.yellow[800]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[800]!),
                        ),
                        counterText:
                        '${viewModel.userProfile?.bio.length}/${viewModel.bioMaxLength}',
                      ),
                      maxLength: viewModel.bioMaxLength,
                      keyboardType: TextInputType.text,
                      onChanged: viewModel.setBio,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      name: 'upload profile picture',
                      onPressed:() async {
                        // await viewModel.pickAndUploadProfilePicture();
                      } ,
                    )
                  ,
                    if (viewModel.userProfile?.profilePictureUrl.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image.network(viewModel.userProfile!.profilePictureUrl),
                      ),
                    const SizedBox(height: 20),
                    const Text('User Type'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 12.0,


                      children: userTypes.map((userType) {
                        return ChoiceChip(
                          label: Text(userType),
                          selected: viewModel.userProfile?.userType == userType,
                          onSelected: (selected) {
                            if (selected) {
                              viewModel.setUserType(userType);
                            }
                          },
                          backgroundColor: Colors.white,
                          elevation: 2,
                          side: BorderSide(color: Colors.grey,width: .5),
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(7)),
                          selectedColor: Colors.yellow[700],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text('Tags'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      children: availableTags.map((tag) {
                        return ChoiceChip(
                          label: Text(tag),
                          selected: viewModel.userProfile?.tags.contains(tag) ?? false,
                          onSelected: (selected) {
                            viewModel.toggleTag(tag);
                          },
                          backgroundColor: Colors.yellow[100],
                          selectedColor: Colors.yellow[700],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[800],
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        onPressed: () async {
                            

                          // await viewModel.submitProfile();
                        },
                        child: const Text('Create Profile', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
