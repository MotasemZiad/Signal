import 'package:flutter/material.dart';
import 'package:signal_chat/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  void _pickImage() {
    ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 42.0,
              backgroundColor: primaryColor,
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
