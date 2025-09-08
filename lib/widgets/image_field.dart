import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ImageFieldState();
  }
}

class _ImageFieldState extends State<ImageField> {
  File? _pickedImage;

  void _useCamera() async {
    final piture = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 500,
    );

    if (piture == null) {
      return;
    }

    setState(() {
      _pickedImage = File(piture.path);
    });
  }

  void _useGallery() async {
    final piture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
    );

    if (piture == null) {
      return;
    }

    setState(() {
      _pickedImage = File(piture.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colorScheme.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _pickedImage != null
              ? Image.file(_pickedImage!, width: 200)
              : Text("No image selected"),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _useCamera,
            label: Text("Camera"),
            icon: Icon(Icons.camera),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _useGallery,
            label: Text("Gallery"),
            icon: Icon(Icons.image),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
