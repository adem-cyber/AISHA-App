import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/store_list.dart';

import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  const EditProduct(
      {Key? key,
      required this.id,
      required this.storeid,
      required this.name,
      required this.description,
      required this.image,
      required this.price})
      : super(key: key);
  final String? id;
  final String storeid; // Declare the storeid as a property
  final String description;
  final String name;
  final String image;
  final String price;
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late ImagePicker picker;
  final _db = FirebaseFirestore.instance;

  final sender = StoreRepoVendor();
  late UserModelVendor userData;
  File? _image; // Store the selected image file

  @override
  void initState() {
    _fetchUserData();
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    _priceController = TextEditingController(text: widget.price ?? '');
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
    picker = ImagePicker();
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
          title: const Text('Edit Products'),
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
                  //_image=widget.image as File?;
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
// Display the selected image
                  _buildImageDisplay(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmationDialog(context);
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _addItemToDatabase(BuildContext context) async {
    if (widget.image == null) {
      // Ensure an image is selected before adding to the database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
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
      'Storeid': widget.storeid,
    };

    if (_image != null) {
      itemData['image'] = await _uploadImageToStorage();
    }

    // Add the data to Firestore based on the selected type
    try {
      await _db.collection("Products").doc(widget.id).update(itemData);

      // Navigate back to the StoreList page
    } catch (e) {
      Get.snackbar('Error', 'Failed to update Product. Please try again.');
    }
    Get.snackbar(
        'Product Updated', 'Your Product has been updated successfully!');

    _navigateToStoreList();
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
      return Image.file(
        _image!,
        height: 200,
      );
    } else {
      return Image.network(
        widget.image,
        height: 150,
      ); // Return an empty container when there's no image
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
                Navigator.of(context)
                    .pop(false); // Close the dialog and pass false
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Close the dialog and pass true
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
