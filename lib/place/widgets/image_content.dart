import 'dart:io';

import 'package:flutter/material.dart';

class ImageContent extends StatelessWidget {
  final void Function() takePicture;
  final File? selectedImage;
  const ImageContent(
      {super.key, required this.takePicture, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: takePicture,
      child: Image.file(
        selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
