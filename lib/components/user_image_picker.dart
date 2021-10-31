import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File? image) imagePick;
  const UserImagePicker({
    Key? key,
    required this.imagePick,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image; //precisa estar dentro do state

  Future<void> _takeImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile _pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    ) as XFile;

    setState(() {
      _image = File(_pickedImage.path);
    });

    widget.imagePick(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image == null ? null : FileImage(_image!),
        ),
        TextButton(
          onPressed: _takeImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image),
              SizedBox(width: 10),
              Text('Adicionars imagem'),
            ],
          ),
        ),
      ],
    );
  }
}
