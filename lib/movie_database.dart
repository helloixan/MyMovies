import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'movie_model.dart';

class MovieDatabase {
  static final MovieDatabase instance = MovieDatabase._init();
  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        year TEXT,
        review TEXT,
        rating REAL
      )
    ''');
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await instance.database;
    return await db.insert('movies', movie.toMap());
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await instance.database;
    final result = await db.query('movies');
    return result.map((json) => Movie.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
