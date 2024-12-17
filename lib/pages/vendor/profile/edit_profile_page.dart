import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/profile/account_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:get/get.dart';

class EditProfilePagevendor extends StatefulWidget {
  final UserModelVendor currentUser;

  const EditProfilePagevendor({super.key, required this.currentUser});

  @override
  _EditProfilePageVendorState createState() => _EditProfilePageVendorState();
}

class _EditProfilePageVendorState extends State<EditProfilePagevendor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _phoneController.text = widget.currentUser.phone;
    _addressController.text = widget.currentUser.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileControllervendor());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16.0),
            TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Location')),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Update the user's profile information using ProfileController
                  UserModelVendor updatedUser = UserModelVendor(
                    id: widget.currentUser.id,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    // email: widget.currentUser.email,
                    address: _addressController.text,
                    vendorid: widget.currentUser.vendorid,
                  );

                  if (_nameController.text.isEmpty ||
                      _addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill out all the information.'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    return;
                  }
                  Get.dialog(
                    const Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );
                  bool updateSuccess =
                      await controller.updateUserData(updatedUser);

                  if (updateSuccess) {
                    //Navigator.pop(context, updatedUser);
                    Get.to(() => HomePagevendor());
                    Get.snackbar('Profile Updated',
                        'Your profile has been updated successfully!');
                  } else {
                    Get.snackbar(
                        'Error', 'Failed to update profile. Please try again.');
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

    _addressController.dispose();
    super.dispose();
  }
}
