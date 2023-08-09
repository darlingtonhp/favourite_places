import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:bloc/bloc.dart';
import 'package:favourite_places/model/place.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE places(id TEXT PRIMARY KEY,title TEXT, image TEXT )',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesCubit extends Cubit<List<Place>> {
  List<Place> updatedList = [];
  UserPlacesCubit() : super((const []));

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('places');
    final places = data
        .map(
          (row) => Place(
              id: row['id'] as String,
              image: File(row['image'] as String),
              title: row['title'] as String),
        )
        .toList();
    emit(places);
  }

  Future<void> addPlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy("${appDir.path}/$fileName");

    final place = Place(title: title, image: copiedImage);
    final db = await _getDatabase();
    db.insert(
      'places',
      {
        'id': place.id,
        'title': place.title,
        'image': place.image.path,
      },
    );
    updatedList.add(place);
    emit(updatedList);
  }
}
