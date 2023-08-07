import 'dart:io';

import 'package:favourite_places/place/cubit/user_places_cubit.dart';
import 'package:favourite_places/place/widgets/image_input.dart';
import 'package:favourite_places/place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlaceView extends StatefulWidget {
  const AddPlaceView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceView();
  }
}

class _AddPlaceView extends State<AddPlaceView> {
  File? _selectedImage;
  late TextEditingController _controller;

  void _savePlace() {
    final enteredText = _controller.text;
    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }
    context.read<UserPlacesCubit>().addPlace(enteredText, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: _controller,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            const LocationInput(),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
