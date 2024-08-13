import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smallbytes/features/profileCreate/service/ProfileService.dart';
import 'package:smallbytes/features/profileCreate/user_profile.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _profileService;
  UserProfile? _userProfile;

  ProfileViewModel({required ProfileService profileService})
      : _profileService = profileService;

  void setUserProfile(UserProfile user) {
    _userProfile = user;
    notifyListeners();
  }

  UserProfile? get userProfile => _userProfile;

  final picker = ImagePicker();
  int bioMaxLength = 150;

  void setEmail(String email) {
    _userProfile?.email = email;
    notifyListeners();
  }

  void setBio(String bio) {
    _userProfile?.bio = bio;
    notifyListeners();
  }

  void setId(String id) {
    _userProfile?.uid = id;
    notifyListeners();
  }

  void setName(String name) {
    _userProfile?.name = name;
    notifyListeners();
  }

  void setUserType(String userType) {
    _userProfile?.userType = userType;
    notifyListeners();
  }

  void toggleTag(String tag) {
    if (_userProfile?.tags.contains(tag) ?? false) {
      _userProfile?.tags.remove(tag);
    } else {
      _userProfile?.tags.add(tag);
    }
    notifyListeners();
  }

  Future<void> pickAndUploadProfilePicture() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileUrl = await _profileService.uploadProfilePicture(
          pickedFile.path, pickedFile.name, "jpg");
      _userProfile?.profilePictureUrl = fileUrl;
      notifyListeners();
    }
  }

  Future<void> submitProfile() async {
    try {
      await _profileService.createProfile(_userProfile!);
    } catch (error) {
      print('Error creating profile: $error');
    }
  }
}
