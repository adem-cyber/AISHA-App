import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/repository/store_repo_vendor.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';

import 'package:flutter_application_1/pages/vendor/home/home_page_vendor.dart';
import 'package:flutter_application_1/pages/vendor/home/main_vendor_body.dart';

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

class EditItemPage extends StatefulWidget {
  const EditItemPage({Key? key,required this.id,required this.name,required this.description,
  required this.type,required this.location,required this.email,required this.phone,
  required this.image,}) : super(key: key);
 final String? id;
 final  String name;
  final String? description;
  final String? type;
  final String image;
  final String? phone;
  final String? email;
  final String location;
  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
 late TextEditingController _nameController;
 late TextEditingController _locationController;
 late TextEditingController _emailController;
 late TextEditingController _phoneController;
 late TextEditingController _descriptionController;
  late ImagePicker picker;
  final _db = FirebaseFirestore.instance;
   final sender =Get.put(StoreRepoVendor());
   String? _selectedType='Tech';
  
 var storeid = const Uuid().v4();
  late UserModelVendor userData;
  File? _image; // Store the selected image file

  @override
  void initState() {
    _fetchUserData();
    super.initState();
     _nameController = TextEditingController(text: widget.name ?? '');
   _locationController= TextEditingController(text: widget.location ?? '');
   _emailController= TextEditingController(text: widget.email ?? '');
   _phoneController= TextEditingController(text: widget.phone ?? '');
   _descriptionController= TextEditingController(text: widget.description ?? '');
  picker = ImagePicker(); 
  _selectedType=Type();
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
String? Type(){
  return widget.type;
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Store'),
        backgroundColor: AppColors.yellowcolor, 
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type'),
                value: widget.type,
                onChanged: (newValue) {
                  setState(() {
                   _selectedType = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type';
                  }
                  return null;
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showConfirmationDialog(context);
                    
                  }
                  
                },
                
                child: const Text('Save Changes'),
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
   // String value = _selectedType;
   

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
  final updateData = {
    'Name': _nameController.text,
    'Location': _locationController.text,
    'Phone': _phoneController.text,
    'Description': _descriptionController.text,
    'Email': _emailController.text,
    'Type': _selectedType,
  };

  if (_image != null) {
    updateData['ImageURL'] = await _uploadImageToStorage();
  }

  await _db.collection("Grocery").doc(widget.id).update(updateData);

  // Update successful, you can add further actions here if needed.
} catch (e) {
     Get.snackbar(
                        'Error', 'Failed to update Store. Please try again.');
                  
  }
   Get.snackbar('Store Updated',
                        'Your Store has been updated successfully!');
    _nameController.clear();
    _locationController.clear();
    _phoneController.clear();
    _descriptionController.clear();
    _emailController.clear();

 Get.to(()=>HomePagevendor());
setState(() {
        storeid = const Uuid().v4(); 
        _image = null;
       
      });

    // Navigate back to the home page
   // Navigator.of(context).popUntil((route) => route.isFirst);
   
  }

  Future<String> _uploadImageToStorage() async {
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
