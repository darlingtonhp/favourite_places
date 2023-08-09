import 'package:favourite_places/place/cubit/user_places_cubit.dart';
import 'package:favourite_places/place/views/add_place.dart';
import 'package:favourite_places/place/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesView extends StatefulWidget {
  const PlacesView({super.key});

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = context.read<UserPlacesCubit>().loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceView(),
                ),
              );
            },
          )
        ],
      ),
      body: Builder(builder: (context) {
        final places = context.watch<UserPlacesCubit>().state;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlacesList(places: places),
          ),
        );
      }),
    );
  }
}
