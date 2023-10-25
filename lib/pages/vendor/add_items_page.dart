import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/main_vendor_body.dart';
import 'package:flutter_application_1/pages/vendor/home/store_list.dart';

import 'package:flutter_application_1/pages/vendor/profile_controller_vendor.dart';
import 'package:flutter_application_1/pages/vendor/user_model_vendor.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/widgets/account_widget.dart';
import 'package:flutter_application_1/widgets/app_icon.dart';
import 'package:flutter_application_1/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _db = FirebaseFirestore.instance;
   final sender =Get.put(StoreRepoVendor());
  final picker = ImagePicker();
  String _selectedType = 'Restaurant';
 var storeid = const Uuid().v4();
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
        title: const Text('Create Store'),
        
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type'),
                value: _selectedType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'Restaurant',
                    child: Text('Restaurant'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Grocery',
                    child: Text('Grocery'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Tech',
                    child: Text('Tech'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Pharmaceutical',
                    child: Text('Pharmaceutical'),
                  ),
                ],
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
               
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
               
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
               ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
             
  _buildImageDisplay(),
                SizedBox(height:Dimensions.height10),
                
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog(context);
                    
                  }
                  
                },
                
                child: const Text('Add Store'),
              ),
             
              // Add an image picker button
             
            ],
          ),
        ),
      ),
    )
    );
  }
  

  Future<void> _addItemToDatabase(BuildContext context) async {
    String value = _selectedType;
    

    if (_image == null) {
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
      _emailController.text.isEmpty ||
       _locationController.text.isEmpty ||
        _phoneController.text.isEmpty ||
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

  try {
      await _db.collection("Grocery").add({
        'Name': _nameController.text,
        'Location': _locationController.text,
        'Phone': _phoneController.text,
        'Description':_descriptionController.text,
        'Email': _emailController.text,
       'Store_id': storeid,
        'Vendor_id': userData.vendorid,
        'ImageURL': await _uploadImageToStorage(),
        'Type':_selectedType,
      });
     
    } catch (e) {
     Get.snackbar(
                        'Error', 'Failed to Add Store. Please try again.');
                  
  }
   Get.snackbar('Product Added',
                        'Your Store has been Added successfully!');
 Get.to(()=>HomePagevendor());
    //_navigateToStoreList();
    _nameController.clear();
    _locationController.clear();
    _phoneController.clear();
    _descriptionController.clear();
    _emailController.clear();
_selectedType='Restaurant';
setState(() {
        storeid = const Uuid().v4(); 
        _image = null;
       
      });

    // Navigate back to the home page
   // Navigator.of(context).popUntil((route) => route.isFirst);
    
  }
Future<void> _navigateToStoreList() async {
  final storeDataList = await sender.getStore(storeid);
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
    }
   else {
    return const SizedBox(); // Return an empty container when there's no image
  }
}
// Modify the image display part to handle both web and mobile

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