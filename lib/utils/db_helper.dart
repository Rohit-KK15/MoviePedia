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

  Future<List<Movie>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query('movies');
    print(maps);
    return List.generate(maps.length, (index) {
      return Movie.fromMap(maps[index]);
    });
  }

  Future<List<Movie>> getMovies() async {
    final List<Map<String, dynamic>> maps = await _database.query('movies', where: 'ms = ?', whereArgs: [true]);
    print(maps);
    return List.generate(maps.length, (index) {
      return Movie.fromMap(maps[index]);
    });
  }

  Future<List<Movie>> getTVShows() async {
    final List<Map<String, dynamic>> maps = await _database.query('movies', where: 'ms = ?', whereArgs: [false]);
    print(maps);
    return List.generate(maps.length, (index) {
      return Movie.fromMap(maps[index]);
    });
  }
}