import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _phoneController.text = widget.currentUser.phone;
    _emailController.text = widget.currentUser.email;
    _addressController.text = widget.currentUser.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16.0),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 16.0),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16.0),
            TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Update the user's profile information using ProfileController
                  UserModel updatedUser = UserModel(
                    id: widget.currentUser.id,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    email: _emailController.text,
                  // Keep the existing password
                    address: _addressController.text,
                  );

                  bool updateSuccess = await controller.updateUserData(updatedUser);

                  if (updateSuccess) {
                    Get.snackbar('Profile Updated', 'Your profile has been updated successfully!');
                   Navigator.pop(context, updatedUser);
                  } else {
                    Get.snackbar('Error', 'Failed to update profile. Please try again.');
                  }
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
    
  }
  
}
