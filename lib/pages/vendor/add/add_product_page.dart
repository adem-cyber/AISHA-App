import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/store_list.dart';

import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key, required this.storeid}) : super(key: key);
  final String storeid; // Declare the storeid as a property
 /* final String description;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String location;*/
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController(); // Added price controller
  final _descriptionController = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final picker = ImagePicker();
  final sender = StoreRepoVendor();
 final String availability ='Available';
  late UserModelVendor userData;
  File? _image; // Store the selected image file

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    final controller = Get.find<ProfileControllervendor>();
    final user = await controller.getUserData();
    if (user != null) {
      setState(() {
        userData = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        backgroundColor: AppColors.purple, 
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
               
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
               
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
                
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              // Display the selected image
             _buildImageDisplay(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog(context);
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  Future<void> _addItemToDatabase(BuildContext context) async {
  
  if (_image == null) {
    // Ensure an image is selected before adding to the database
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('please Pick an image.'),
        duration: Duration(seconds: 2),
      ),
    );
  
    return;
  }
if (_nameController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _descriptionController.text.isEmpty) {
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
  // Create a map with the desired data fields
  final Map<String, dynamic> itemData = {
    'Name': _nameController.text,
    'Price': _priceController.text,
    'Description': _descriptionController.text,
    'image': await _uploadImageToStorage(),
    'Storeid': widget.storeid,
    'Availability':availability
  };

  // Add the data to Firestore based on the selected type
  try {
    await _db
        .collection("Products").add(itemData);
   
  } catch (e) {
     Get.snackbar(
                        'Error', 'Failed to Add Product. Please try again.');
                  
  }
   Get.snackbar('Product Added',
                        'Your Product has been Added successfully!');
    _navigateToStoreList();
    // Clear the fields
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();

}
 Future<void> _navigateToStoreList() async {
  final storeDataList = await sender.getStore(widget.storeid);
  if (storeDataList.isNotEmpty) {
    final productData = storeDataList.first; // Get the first item
    print('Navigating to StoreList with data: $productData'); // Debugging
    // Navigate back to the StoreList page and pass data as arguments
    Get.to(() => const StoreList(), arguments: {
      'name': productData.name,
      'description': productData.description,
      'location': productData.location,
      'storeid': productData.storeid,
      'email': productData.email,
      'phone': productData.phone,
      'image': productData.image,
    });
  } else {
    print('snapshot is empty'); // Debugging
  }
}

  Future<String?> _uploadImageToStorage() async {
    final storage = FirebaseStorage.instance;
    final imageName = '${const Uuid().v4()}.jpg'; // Unique image name
    final ref = storage.ref().child('images/$imageName');
    await ref.putFile(_image!);
    return await ref.getDownloadURL();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  Widget _buildImageDisplay() {
  if (_image != null) {
   
    
      // On mobile, display the image using the 'Image.file' widget
      return Image.file(
        _image!,
        height: 200,
      );
    }
  else {
    return const SizedBox(); // Return an empty container when there's no image
  }
}

  Future<void> _showConfirmationDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to add this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Close the dialog and pass false
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Close the dialog and pass true
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  ).then((value) {
    if (value == true) {
      // Proceed to _addItemToDatabase only when "Yes" is pressed
      _addItemToDatabase(context);
    }
  });
}
}
