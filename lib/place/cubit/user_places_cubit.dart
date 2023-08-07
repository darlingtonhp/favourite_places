import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:favourite_places/model/place.dart';

class UserPlacesCubit extends Cubit<List<Place>> {
  List<Place> updatedList = [];
  UserPlacesCubit() : super((const []));

  void addPlace(String title, File image) {
    final place = Place(title: title, image: image);
    updatedList.add(place);
    emit(updatedList);
  }
}
