import 'dart:io';
import 'package:dummyprojecr/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ProfileViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  ProfileModel? _profile;
  bool _isEditing = false;
  bool _isLoading = true;

 
  ProfileModel? get profile => _profile;
  bool get isEditing => _isEditing;
  bool get isLoading => _isLoading;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  
  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _profile = ProfileModel.fromMap(userDoc.data() as Map<String, dynamic>);

       
        nameController.text = _profile?.name ?? '';
        phoneController.text = _profile?.phone ?? '';
        emailController.text = _profile?.email ?? '';
        usernameController.text = _profile?.username ?? '';
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  
  Future<void> updateUserData(String userId, BuildContext context) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'username': usernameController.text,
      });

      _profile = ProfileModel(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        username: usernameController.text,
        profilePicture: _profile?.profilePicture ?? '',
      );

      _isEditing = false;
      notifyListeners();

      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!"), backgroundColor: Colors.green),
      );
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  
  Future<void> uploadProfilePicture(String userId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);

    try {
      String filePath = 'profile_pictures/$userId.jpg';
      TaskSnapshot snapshot = await _storage.ref(filePath).putFile(imageFile);

      String downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('users').doc(userId).update({'profilePicture': downloadUrl});

      _profile = ProfileModel(
        name: _profile!.name,
        phone: _profile!.phone,
        email: _profile!.email,
        username: _profile!.username,
        profilePicture: downloadUrl,
      );

      notifyListeners();
    } catch (e) {
      print("Error uploading profile picture: $e");
    }
  }

 
  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }
}
