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
  File? _storedImage; //precisa estar dentro do state

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _storedImage == null ? null : FileImage(_storedImage!),
        ),
        TextButton(
          onPressed: _takePicture,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image),
              SizedBox(width: 10),
              Text('Selecionar imagem'),
            ],
          ),
        ),
      ],
    );
  }
}
