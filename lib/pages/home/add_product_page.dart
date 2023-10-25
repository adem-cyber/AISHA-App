import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data/repository/auth_repo.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Store'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              
              bool addedSuccessfully = await _addItemToDatabase();
              Get.dialog(
                              const Center(child: CircularProgressIndicator()),
                              barrierDismissible: false,
                            );
              if (addedSuccessfully) {
                _showSuccessSnackBar();
                Navigator.pop(context); // Go back to the previous page
              } else {
                _showFailureSnackBar();
              }
            }
          },
          child: const Text('Add Store'),
        ),
        const SizedBox(height: 20),
      

                  

      ],
    ),
  ),
)
);
}

Future<bool> _addItemToDatabase() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      

      final imageURL = await uploadImageToStorage();

      await FirebaseFirestore.instance.collection('items').add({
        'name': _nameController.text,
        'type': _typeController.text,
        'price': double.parse(_priceController.text),
        'imageURL': imageURL,
        'userId': user.uid,
      
      });

      return true; // Success
    } catch (error) {
      print('Error adding item: $error');
      return false; // Failure
    }
  }
  return false;
}


  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item added successfully!')),
    );
  }

  void _showFailureSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to add item. Please try again.')),
    );
  }
  Future<void> _pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
 
  Future<String> uploadImageToStorage() async {
  try {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref().child('item_images/${DateTime.now()}.png');

    final uploadTask = storageRef.putFile(_image!);

    final TaskSnapshot downloadUrl = await uploadTask;

    final String url = await downloadUrl.ref.getDownloadURL();

    return url;
  } catch (error) {
    print('Error uploading image: $error');
    return ''; // Return an empty string or handle the error as needed.
  }
}

  }

