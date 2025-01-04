import 'dart:io';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';

class UpdateProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxString profileImageUrl = ''.obs;

  final String userId = AuthenticationRepositories.instance.authUser?.uid ?? '';

  final UserRepositories userRepositories = Get.put(UserRepositories());

  @override
  void onInit() {
    super.onInit();
    _loadProfileImageUrl();
  }

  Future<void> _loadProfileImageUrl() async {
    try {
      final user = await userRepositories.fetchUserDetails();
      profileImageUrl.value = user.profilePicture;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> pickImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      uploadProfileImage(file);
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    try {
      String fileName =
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;

      String downloadUrl = await storageReference.getDownloadURL();
      profileImageUrl.value = downloadUrl;

      await updateProfileImage(downloadUrl);

      Get.snackbar('Success', 'Profile picture updated successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
  }

  Future<void> updateProfileImage(String downloadUrl) async {
    try {
      Map<String, dynamic> profileData = {
        'ProfilePicture': downloadUrl,
      };

      await userRepositories.updateSingleField(profileData);

      Get.snackbar('Success', 'Profile picture URL saved to Firestore!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile picture URL: $e');
    }
  }
}
