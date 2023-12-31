import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/movie_model.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'movie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            name TEXT,
            desc TEXT,
            ms INTEGER,
            bannerUrl TEXT,
            posterUrl TEXT,
            vote TEXT,
            launchOn TEXT,
            cast TEXT,
            crew TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMovie(Movie movie) async {
    await _database.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("added");
    print(movie.toMap());
  }

  Future<void> deleteMovie(int id) async {
    await _database.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("deleted");
  }

  Future<bool> isMovieExists(int id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.rawQuery('SELECT * FROM movies');
    print(maps);
    return maps;
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    final List<Map<String, dynamic>> maps = await _database.rawQuery('SELECT * FROM movies WHERE ms = 1');
    print(maps);
    return maps;
  }

  Future<List<Map<String, dynamic>>> getTVShows() async {
    final List<Map<String, dynamic>> maps = await _database.rawQuery('SELECT * FROM movies WHERE ms = 0');
    print(maps);
    return maps;
  }

  Future<Map<String, dynamic>> getCast(int id) async {
    final List<Map<String, dynamic>> cast = await _database.rawQuery('SELECT * FROM movies WHERE id = $id');
    print(cast);
    return cast[1]['cast'];
  }

  Future<List> getCrew(int id) async {
    final List crew = await _database.rawQuery('SELECT * FROM movies WHERE id = $id');
    print(crew);
    return crew;
  }
}