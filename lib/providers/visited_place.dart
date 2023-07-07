import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:visited_places/models/visited_place_model.dart';

Future<Database> _getDb() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'my_places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE my_places(id TEXT PRIMARY KEY,title TEXT, date TEXT , image TEXT, notes TEXT)');
    },
    version: 1,
  );
  return db;
}

class VisitedPlacesNotifier extends StateNotifier<List<VisitedPlace>> {
  VisitedPlacesNotifier() : super(const []);

  Future<void> loadVisitedPlaces() async {
    final db = await _getDb();
    final data = await db.query('my_places');
    final placesList = data
        .map(
          (row) => VisitedPlace(
            id: row['id'] as String,
            title: row['title'] as String,
            date: DateTime.parse(row['date'] as String),
            image: File(row['image'] as String),
          ),
        )
        .toList();
    state = placesList;
  }

  void addVisitedPlace(String title, DateTime date, File image) async {
    final photoDirectory = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final storedPhoto = await image.copy('${photoDirectory.path}/$filename');
    final newVisitedPlace =
        VisitedPlace(title: title, date: date, image: storedPhoto);

    final db = await _getDb(); // otwarcie database zanim cos dodamy
    db.insert('my_places', {
      //dodawania zawartości do database
      'id': newVisitedPlace.id,
      'title': newVisitedPlace.title,
      'date': date.toIso8601String(),
      'image': newVisitedPlace.image.path
    });

    state = [newVisitedPlace, ...state];
  }
}

final visitedPlacesProvider =
    StateNotifierProvider<VisitedPlacesNotifier, List<VisitedPlace>>((ref) {
  return VisitedPlacesNotifier();
});
