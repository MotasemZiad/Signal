import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signal_chat/utils/constants.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.pickImageFunction})
      : super(key: key);

  final void Function(XFile pickedImage) pickImageFunction;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select the image source'),
        elevation: 6.0,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Camera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );
    if (imageSource != null) {
      final file = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 70,
        maxWidth: 150.0,
      );
      if (file != null) {
        setState(() {
          _pickedImage = file;
        });
        widget.pickImageFunction(_pickedImage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 42.0,
              backgroundColor: primaryColor,
              backgroundImage: _pickedImage != null
                  ? FileImage(File(_pickedImage!.path))
                  : null,
            ),
            Positioned(
              bottom: -16.0,
              right: -4.0,
              child: IconButton(
                onPressed: _pickImage,
                icon: const Icon(
                  Icons.image,
                  size: 24.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
