import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImages = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImages == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImages.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Enhanced CircleAvatar with a border
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade300,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          child: _pickedImageFile == null
              ? Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey.shade600,
                )
              : null,
        ),
        SizedBox(height: 10),
        // Updated TextButton with icon and improved styling
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image, color: Colors.deepPurpleAccent),
          label: Text(
            'Add Image',
            style: TextStyle(
                color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.deepPurpleAccent, width: 1),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
