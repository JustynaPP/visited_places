import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMainImage extends StatefulWidget {
  const AddMainImage({Key? key, required this.onChosenImage}) : super(key: key);
  final void Function(File picture) onChosenImage;

  @override
  State<AddMainImage> createState() => _AddMainImageState();
}

class _AddMainImageState extends State<AddMainImage> {
  File? _selectedPhoto;

  final imagePicker = ImagePicker();

  void _choosePhoto() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedPhoto = File(pickedImage.path);
    });
    widget.onChosenImage(_selectedPhoto!);
  }

  void _takePhoto() async {
    final takenPhoto =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (takenPhoto == null) {
      return;
    }
    setState(() {
      _selectedPhoto = File(takenPhoto.path);
    });
    widget.onChosenImage(_selectedPhoto!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          icon: Icon(
            Icons.camera_alt_outlined,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: const Text(
            'Take a photo',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: _takePhoto,
        ),
        const Text('or'),
        TextButton.icon(
          icon: Icon(
            Icons.photo_library_outlined,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: const Text(
            'Choose a picture from gallery',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: _choosePhoto,
        ),
      ],
    );

    if (_selectedPhoto != null) {
      content = GestureDetector(
        onTap: () {
          setState(() {
            _selectedPhoto = null;
          });
        },
        child: Image.file(
          _selectedPhoto!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        child: content);
  }
}
