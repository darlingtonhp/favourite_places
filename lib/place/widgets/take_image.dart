import 'package:flutter/material.dart';

class TakeImageButton extends StatelessWidget {
  final void Function() takePicture;
  const TakeImageButton({
    super.key,
    required this.takePicture,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text("Take a picture"),
      onPressed: takePicture,
    );
  }
}
