import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final Function(File image) onImageSelected;

  const ImageField({super.key, required this.onImageSelected});

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _selectedImage != null
              ? Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
              : Icon(Icons.image, size: 100, color: Colors.grey),
          _selectedImage == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No image selected.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _takePhoto,
            icon: Icon(Icons.camera_alt),
            label: Text("Take Photo"),
          ),
          SizedBox(height: 4),
          TextButton.icon(
            onPressed: _selectImage,
            icon: Icon(Icons.image),
            label: Text("Select Image"),
          ),
        ],
      ),
    );
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (photo == null) {
      return;
    }
    setState(() {
      _selectedImage = File(photo.path);
    });
    widget.onImageSelected(_selectedImage!);
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
    });
    widget.onImageSelected(_selectedImage!);
  }
}
